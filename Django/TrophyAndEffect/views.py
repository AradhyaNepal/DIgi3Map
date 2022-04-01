from itertools import count
from rest_framework.decorators import api_view,permission_classes
from rest_framework import status
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from GroupPortal.models import Leaderboard
from .models import Effect, Trophy,UserTrophy

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
                {"Error":"No Result Found"}
            )

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getUserTrophy(request):
    count=getUserTrophyMethod(request.user.id)
    return Response(
        {
            "Count":str(count)
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
            userTrophy=UserTrophy.objects.create(user_id=request.user,effect_id=effect)
            trophy=Trophy.objects.create(user_id=request.user,count=-effectCost)
            trophy.save()
            userTrophy.save()
        else:
            return Response(
                {
                    "You Can't Affort It":True
                }
            )
    except Effect.DoesNotExist:
        return Response(
            {"Cannot Find":True}
        )

def getUserTrophyMethod(userId):
    trophy=Trophy.objects.filter(user_id=userId)
    count=0
    for single in trophy:
        count=count+single.count
    return count