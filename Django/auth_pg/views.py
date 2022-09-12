from django.contrib.auth import get_user_model
from numpy import require
from rest_framework.decorators import api_view,permission_classes
from rest_framework.response import Response
from rest_framework.authtoken.serializers import AuthTokenSerializer
from knox.auth import AuthToken

from Task.models import RandomTask
from .serializer import RegisterSerializer, UserProgressSerializer
from rest_framework import status
from rest_framework import generics
from rest_framework.response import Response
from .serializer import ChangePasswordSerializer,UserProfileSerializer,UserImageSerializer
from rest_framework.permissions import IsAuthenticated  

@permission_classes(IsAuthenticated)
@api_view(['GET'])
def updateWorkout(request,oneForYes):
    user=get_user_model().objects.get(id=request.user.id)
    if oneForYes==1:
        user.finess_points=user.finess_points+5
        user.workout_progress=user.workout_progress+10
        if user.progress_percentage<2:
            user.progress_percentage=user.progress_percentage+0.05
    elif user.progress_percentage>0.5:
        user.progress_percentage=user.progress_percentage-0.05
    
    user.save()
    return Response(
        {"details":"Sucessfully Added"},
    
    )



@api_view(['GET'])
def getOnePercentage(request,userId):
    try:
        user=get_user_model().objects.get(id=userId)
        return Response(
            {
                "details":user.progress_percentage
            }
        )
    except get_user_model().DoesNotExist:
        return Response(
            {"details":"Wrong User"},
            status=status.HTTP_400_BAD_REQUEST
        )

@permission_classes(IsAuthenticated)
@api_view(['GET'])
def updateLearning(request,oneForYes):
    user=get_user_model().objects.get(id=request.user.id)
    if oneForYes==1:
        user.carrer_points=user.carrer_points+5
        user.learning_progress=user.learning_progress+10
        if user.progress_percentage<2:
            user.progress_percentage=user.progress_percentage+0.05
    elif user.progress_percentage>0.5:
        user.progress_percentage=user.progress_percentage-0.05
    
    user.save()
    return Response(
        {"details":"Sucessfully Added"},
    
    )

@permission_classes(IsAuthenticated)
@api_view(['GET'])
def updateImplementing(request,oneForYes):
    user=get_user_model().objects.get(id=request.user.id)
    if oneForYes==1:
        user.carrer_points=user.carrer_points+5
        user.implementing_progress=user.implementing_progress+10
        if user.progress_percentage<2:
            user.progress_percentage=user.progress_percentage+0.05
    elif user.progress_percentage>0.5:
        user.progress_percentage=user.progress_percentage-0.05
    
    user.save()
    return Response(
        {"details":"Sucessfully Added"},
    
    )



def increaseDecreaseProgress(user,oneForYes):
    if oneForYes==1: 
        if user.progress_percentage<2:
            user.progress_percentage=user.progress_percentage+0.05
    elif user.progress_percentage>0.5:
        user.progress_percentage=user.progress_percentage-0.05

@permission_classes(IsAuthenticated)
@api_view(['GET'])
def updateDiet(request,oneForYes):
    user=get_user_model().objects.get(id=request.user.id)
    if oneForYes==1:
        user.finess_points=user.finess_points+5
        user.diet_progress=user.diet_progress+10
        if user.progress_percentage<2:
            user.progress_percentage=user.progress_percentage+0.05
    elif user.progress_percentage>0.5:
        user.progress_percentage=user.progress_percentage-0.05
    
    user.save()
    return Response(
        {"details":"Sucessfully Added"},
    
    )

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
    

@api_view(['POST'])
def social_register(request):
    try:
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
    except:
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


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getUserProfile(request):
    user=get_user_model().objects.get(id=request.user.id)
    userSerialzer=UserProfileSerializer(user)
    return Response(userSerialzer.data)



@api_view(['PATCH'])
@permission_classes([IsAuthenticated])
def updateImage(request):
    user=get_user_model().objects.get(id=request.user.id)
    serializer=UserImageSerializer(user,data=request.data,partial=True)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data,status=status.HTTP_201_CREATED)
    return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)