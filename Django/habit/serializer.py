from rest_framework import serializers

import domain
from .models import Habit, HabitTransaction

class HabitSerializer(serializers.ModelSerializer):
    
    class Meta:
        model=Habit
        fields='__all__'

class HabitDepthSerializer(serializers.ModelSerializer):
    
    class Meta:
        model=Habit
        fields='__all__'
        depth=1

class HabitTransactionSerializer(serializers.ModelSerializer):

    class Meta:
        model=HabitTransaction
        fields='__all__'