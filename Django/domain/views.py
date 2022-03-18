from django.shortcuts import render
from rest_framework.parsers import JSONParser
from django.http import HttpResponse, JsonResponse
from .models import Domain
from .serializer import DomainSerializer
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from habit.models import Habit
from habit.serializer import HabitSerializer
@api_view(['GET','POST'])
def domain_list(request):
    if request.method=='GET':
        domain=Domain.objects.all()
        serializer=DomainSerializer(domain,many=True)
        return Response(serializer.data)
    elif request.method=='POST':
        #data=JSONParser().parse(request)
        serializer=DomainSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data,status=status.HTTP_201_CREATED)
        return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)

        
@api_view(['GET'])
def domain_habits(request,pk):
    if request.method=='GET':
        habit=Habit.objects.filter(domain_id=pk)
        serializer=HabitSerializer(habit,many=True)
        return Response(serializer.data)

@api_view(['GET','PATCH','DELETE',"PUT"])
def domain_detail(request,pk):
    try:
        domain=Domain.objects.get(pk=pk)
    except Domain.DoesNotExist:
        return Response(status=status.HTTP_400_BAD_REQUEST)

    if request.method=='GET':
        serializer=DomainSerializer(domain)
        return Response(serializer.data)
    
    elif request.method=='PUT':
        serializer=DomainSerializer(domain,data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data,status=status.HTTP_201_CREATED)
        return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)

    elif request.method=='PATCH':
        serializer=DomainSerializer(domain,data=request.data,partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data,status=status.HTTP_201_CREATED)
        return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)

    elif request.method=="DELETE":
        domain.delete()
        return Response(status=status.HTTP_201_CREATED)


@api_view(['GET'])
def user_domain(request,user_id):
    if request.method=="GET":
        domain=Domain.objects.filter(user_id=user_id)
        serializer=DomainSerializer(domain,many=True)
        return Response(serializer.data,status=status.HTTP_200_OK)
