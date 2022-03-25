from unittest.mock import patch
from django.shortcuts import render
from rest_framework.parsers import JSONParser
from django.http import HttpResponse, JsonResponse
from .models import Habit
from .serializer import HabitSerializer
from domain import serializer
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView
from domain.models import Domain

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
            
            serializer=HabitSerializer(habit)
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

        

    def delete(self,requrest,id):
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
            serializer=HabitSerializer(userHabits,many=True)
            return Response(serializer.data)
        except Habit.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        
    