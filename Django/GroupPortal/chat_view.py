from urllib import response
from rest_framework.permissions import IsAuthenticated 
from rest_framework.decorators import api_view,permission_classes
from django.contrib.auth import get_user_model
from rest_framework.response import Response
from GroupPortal.serealizer import ChatCreateSerializer, ChatSerializer
from .models import Chat, Leaderboard
from rest_framework import status

@api_view(['GET'])
def getMessage(request,leaderboard_id):
    try:
        leaderboard=Leaderboard.objects.get(id=leaderboard_id)
        userChat=Chat.objects.filter(leaderboard_id=leaderboard).order_by("-id")
        chatSerializer=ChatSerializer(userChat,many=True)
        return Response(
            chatSerializer.data
        )
    except Leaderboard.DoesNotExist:
        return Response(
            {
                "details":"Leaderboard Does Not Exist"
            },
            status=status.HTTP_400_BAD_REQUEST
        )


@api_view(['POST'])
def sendMessage(request):
    serializer=ChatCreateSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data,status=status.HTTP_201_CREATED)
    return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)
   