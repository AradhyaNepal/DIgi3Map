from lib2to3.pgen2 import token
from urllib import request
from django.contrib.auth import get_user_model
from numpy import require
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.authtoken.serializers import AuthTokenSerializer
from knox.auth import AuthToken
from .serializer import RegisterSerializer, UserProgressSerializer
from auth_pg import serializer
from rest_framework import status
from rest_framework import generics
from rest_framework.response import Response
from django.contrib.auth.models import User
from .serializer import ChangePasswordSerializer
from rest_framework.permissions import IsAuthenticated  

@api_view(['Post'])
def login_api(request):
    serializer=AuthTokenSerializer(data=request.data)
    serializer.is_valid(raise_exception=True)
    user=serializer.validated_data["user"]

    _,token=AuthToken.objects.create(user)

    return Response({
        'user_info':{
            'id':user.id,
            'username':user.username,
            'email':user.email
        },
        'token':token
    })


@api_view(['GET'])
def get_user_data(request,pk):
    model = get_user_model()
    user=model.objects.get(id=pk)
    serializer=RegisterSerializer(user)
    return Response(serializer.data,status=status.HTTP_202_ACCEPTED)

@api_view(['PATCH'])
def update_user(request,id):
    try:
        user= get_user_model().objects.get(id=id)
        serializer=UserProgressSerializer(user,data=request.data,partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data,status=status.HTTP_201_CREATED)
        return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)
    except get_user_model().DoesNotExist:
        return Response(status=status.HTTP_400_BAD_REQUEST)

    # model = get_user_model()
    # user=model.objects.get(id=pk)

    # return Response(serializer.data,status=status.HTTP_202_ACCEPTED)

@api_view(['POST'])
def register_api(request):
    serializer=RegisterSerializer(data=request.data)
    serializer.is_valid(raise_exception=True)
    user=serializer.save()
    _,token=AuthToken.objects.create(user)
    return Response({
        'user_info':{
            'id':user.id,
            'username':user.username,
            'email':user.email
        },
        'token':token
    })

class ChangePasswordView(generics.UpdateAPIView):
    serializer_class = ChangePasswordSerializer
    model = get_user_model()
    permission_classes = (IsAuthenticated,)

    def get_object(self, queryset=None):
        obj = self.request.user
        return obj

    def update(self, request, *args, **kwargs):
        self.object = self.get_object()
        serializer = self.get_serializer(data=request.data)

        if serializer.is_valid():
            if not self.object.check_password(serializer.data.get("old_password")):
                return Response({"old_password": ["Wrong password."]}, status=status.HTTP_400_BAD_REQUEST)
           
            self.object.set_password(serializer.data.get("new_password"))
            self.object.save()
            response = {
                'status': 'success',
                'code': status.HTTP_200_OK,
                'message': 'Password updated successfully',
                'data': []
            }

            return Response(response)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)    

