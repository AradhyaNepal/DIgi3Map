import re
from django.shortcuts import render

from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import api_view,permission_classes
from datetime import datetime
from rest_framework.views import APIView
from rest_framework.response import Response
from Task.models import DietTransaction, FitnessTransaction, ImplementTransaction, RandomTask, StudyTransaction
from Task.serializer import DietTransactionSerializer, FitnessTransactionSerializer, ImplementingTransactionSerializer, LearningTransactionSerializer, RandomTaskSerializer
# Create your views here.

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getExcludedFitness(request):
    date=datetime.now().strftime("%Y-%m-%d")
    fitness=FitnessTransaction.objects.filter(user_id=request.user.id,completed_date=date)
    seriaizer=FitnessTransactionSerializer(fitness,many=True)
    return Response(seriaizer.data)

@api_view(['POST'])
def addFitnessTransaction(request):
    serializer=FitnessTransactionSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data,status=status.HTTP_201_CREATED)
    return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getExcludedDiet(request):
    date=datetime.now().strftime("%Y-%m-%d")
    diet=DietTransaction.objects.filter(user_id=request.user.id,completed_date=date)
    seriaizer=DietTransactionSerializer(diet,many=True)
    return Response(seriaizer.data)

@api_view(['POST'])
def addDietTransaction(request):
    serializer=DietTransactionSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data,status=status.HTTP_201_CREATED)
    return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)



@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getExcludedLearning(request):
    date=datetime.now().strftime("%Y-%m-%d")
    study=StudyTransaction.objects.filter(user_id=request.user.id,completed_date=date)
    seriaizer=LearningTransactionSerializer(study,many=True)
    return Response(seriaizer.data)

@api_view(['POST'])
def addLearningTransaction(request):
    serializer=LearningTransactionSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data,status=status.HTTP_201_CREATED)
    return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)



@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getExcludedImplementing(request):
    date=datetime.now().strftime("%Y-%m-%d")
    implement=ImplementTransaction.objects.filter(user_id=request.user.id,completed_date=date)
    seriaizer=ImplementingTransactionSerializer(implement,many=True)
    return Response(seriaizer.data)

@api_view(['POST'])
def addImplementingTransaction(request):
    serializer=ImplementingTransactionSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data,status=status.HTTP_201_CREATED)
    return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)

class RandomTaskView(APIView):
    permission_classes=[IsAuthenticated]
    def get(self,request):
        randomTodo=RandomTask.objects.filter(user_id=request.user)
        serializer=RandomTaskSerializer(randomTodo,many=True)
        return Response(serializer.data)

    def post(self,request):
        serializer=RandomTaskSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)

class RandomTaskDetailView(APIView):
    permission_classes=[IsAuthenticated]

    def get(self,request,task_id):
        try:
            randomTask=RandomTask.objects.get(id=task_id)
            serializer=RandomTaskSerializer(randomTask)
            return Response(serializer.data)
        except RandomTask.DoesNotExist:
            return Response(
                {
                    "details":"Invalid Task Id"
                },
                status=status.HTTP_400_BAD_REQUEST
            )
    def patch(self,request,task_id):
        try:
            randomTask= RandomTask.objects.get(id=task_id)
            serializer=RandomTaskSerializer(randomTask,data=request.data,partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data,status=status.HTTP_201_CREATED)
            return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)
        except RandomTask.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

    def delete(self,request,task_id):
        try:
            randomTask=RandomTask.objects.get(id=task_id)
            randomTask.delete()
            return Response(
                {
                    "details":"Deleted"
                }
            )
        except RandomTask.DoesNotExist:
            return Response(
                {
                    "details":"Id does not exist"
                },
                status=status.HTTP_400_BAD_REQUEST
            )

