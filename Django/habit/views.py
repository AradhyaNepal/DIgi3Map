from .models import Habit, HabitTransaction
from .serializer import HabitDepthSerializer, HabitSerializer, HabitTransactionSerializer
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView
from domain.models import Domain
from datetime import datetime
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import api_view,permission_classes

from django.contrib.auth import get_user_model
class HabitApiView(APIView):
    def get(self,request):
        habit=Habit.objects.all()
        serializer=HabitSerializer(habit,many=True)
        return Response(serializer.data)

    def post(self,request):
        serializer=HabitSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data,status=status.HTTP_201_CREATED)
        return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)

    

class HabitDetailApiView(APIView):
       
    def get(self,request,id):
        try:
            habit= Habit.objects.get(id=id)
        
            serializer=HabitDepthSerializer(habit)
            return Response(serializer.data,status=status.HTTP_201_CREATED)
        except Habit.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    
        
    
    def patch(self,request,id):
        try:
            habit= Habit.objects.get(id=id)
            serializer=HabitSerializer(habit,data=request.data,partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data,status=status.HTTP_201_CREATED)
            return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)
        except Habit.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        

    def delete(self,request,id):
        try:
            habit= Habit.objects.get(id=id)
            habit.delete()
            return Response(status=status.HTTP_201_CREATED)
        except Habit.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)


class UserHabitApiView(APIView):
       
    def get(self,request,user_id):
        try:
            domains=Domain.objects.filter(user_id=user_id)
            habitsList=[]
            for domain in domains:
                habits=Habit.objects.filter(domain_id=domain.id)
                for habit in habits:
                    habitsList.append(habit.id)
            
            userHabits=Habit.objects.filter(pk__in=habitsList)
            serializer=HabitDepthSerializer(userHabits,many=True)
            return Response(serializer.data)
        except Habit.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        
    
@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getChainWhetherBroken(request):
    chainIsBroken=False
    brokenChainNames=""
    domain=Domain.objects.filter(user_id=request.user)
    for single in domain:
        habit=Habit.objects.filter(domain_id=single)
        for single in habit:
            date=datetime.now().strftime("%Y-%m-%d")
            transaction=HabitTransaction.objects.filter(habitId=single,completed_date=date)
            if(transaction.count()==0):
                chainIsBroken=True
                brokenChainNames=brokenChainNames+" "+single.name
    return Response(
        {
            "chainBroken":chainIsBroken,
            "brokenChainNames":brokenChainNames
        }
    )



@api_view(['POST'])

@permission_classes([IsAuthenticated])
def addHabitTransaction(request,oneForSucess):
    serializer=HabitTransactionSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        user=get_user_model().objects.get(id=request.user.id)
        try:
            if oneForSucess==1:
                if user.progress_percentage<2:
                    user.progress_percentage=user.progress_percentage+0.05
            elif user.progress_percentage>0.5:
                user.progress_percentage=user.progress_percentage-0.05
            user.save()
        except:
            return Response(
                {
                    "details":"Server Error"
                },
                status=status.HTTP_400_BAD_REQUEST)
        return Response(serializer.data,status=status.HTTP_201_CREATED)
    return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def addDomainHabitPoints(request,habitId):
    try:  
        habit=Habit.objects.get(id=habitId)#-habitId
        try:
            domain=Domain.objects.get(id=habit.domain_id.id)
            habit.progress=habit.progress+10
            domain.points=domain.points+5
            habit.save()
            domain.save()
            return Response(
                {"details":"added"}
            )
        except Domain.DoesNotExist:
            return Response(
                {
                    "details":"Domain Does Not Found"
                },
                status= status.HTTP_400_BAD_REQUEST
            )
    except Habit.DoesNotExist:
        return Response(
            {
                "details":"Habit Does Not Found"
            },
            status=status.HTTP_400_BAD_REQUEST
        )
    

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getExcludedHabit(request):
    date=datetime.now().strftime("%Y-%m-%d")
    habitTransaction=HabitTransaction.objects.filter(userId=request.user.id,completed_date=date)
    seriaizer=HabitTransactionSerializer(habitTransaction,many=True)
    return Response(seriaizer.data)
  