from datetime import datetime,timedelta
import imp
from itertools import count
from rest_framework.decorators import api_view,permission_classes
from rest_framework import status
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from GroupPortal.models import Leaderboard
from .serializer import UserEffectSerializer
from .models import Effect, Trophy, UserEffect


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def collectTrophy(request,leaderboard_id):
    if request.method=="GET":
        try:
            leaderbaord=Leaderboard.objects.get(id=leaderboard_id,winner_id=request.user.id,trophy_collected=False)
            leaderbaord.trophy_collected=True
            trophy=Trophy.objects.create(user_id=request.user,count=1)
            trophy.save()
            leaderbaord.save()
            return Response(
                {
                    "Collected":"Yes"
                }
            )
        except Leaderboard.DoesNotExist:
            return Response(
                {"Error":"No Result Found"},
                status=status.HTTP_406_NOT_ACCEPTABLE
                
            )



@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getUserAllEffects(request):
    userEffects=UserEffect.objects.filter(user_id=request.user,activatedDate=None)
    serializer=UserEffectSerializer(userEffects,many=True)
    return Response(
        serializer.data
    )

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getUserActivatedEffects(request):
      serializer=UserEffectSerializer(getUserActivatedEffectsMethod(request.user),many=True)
      return Response(
          serializer.data
      )

def getUserActivatedEffectsMethod(user):
    minActivatedDate=datetime.now()-timedelta(days=30)
    return UserEffect.objects.filter(user_id=user,activatedDate__gte=minActivatedDate)

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def activateEffect(request,userEffect_id):
    previousActivatedEffect=getUserActivatedEffectsMethod(request.user)
    count=0
    for single in previousActivatedEffect.iterator():
        count=count+1
    if count==0:

        try:
            effect=UserEffect.objects.get(id=userEffect_id,user_id=request.user,activatedDate=None)
            effect.activatedDate=datetime.now()
            effect.save()
            return Response(
                {
                    "Success":True
                }
            )
        except UserEffect.DoesNotExist:
            return Response(
                {
                    "Error":"Wrong UserId or effect Id",
                    
                },
                status=status.HTTP_400_BAD_REQUEST
            )
    else:
        return Response(
                {
                    "Error":"Effect Already Activated"
                },
                 status=status.HTTP_400_BAD_REQUEST
            )







@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getUserTrophy(request):
    count=getUserTrophyMethod(request.user.id)
    return Response(
        {
            "Count":count
        }
    )


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def collectEffect(request,effectId):
    try:
        #Reduce point
        effect=Effect.objects.get(id=effectId)
        effectCost=effect.requiredTrophy
        totalTrophy=getUserTrophyMethod(request.user.id)
        if effectCost<=totalTrophy:
            userEffect=UserEffect.objects.create(user_id=request.user,effect_id=effect)
            trophy=Trophy.objects.create(user_id=request.user,count=-effectCost)
            trophy.save()
            userEffect.save()
            return Response(
                {
                    "Successfully Bought":True
                }
            )
        else:
            return Response(
                {
                    "You Can't Affort It":""
                   
                },
                status=status.HTTP_403_FORBIDDEN
            )
    except Effect.DoesNotExist:
        return Response(
            {
                "Cannot Find Effect":True
            },
            status=status.HTTP_403_FORBIDDEN
        )

def getUserTrophyMethod(userId):
    trophy=Trophy.objects.filter(user_id=userId)
    count=0
    for single in trophy:
        count=count+single.count
    return count