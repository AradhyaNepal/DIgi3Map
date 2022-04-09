from rest_framework import serializers

import domain
from .models import Habit, HabitTransaction

class HabitSerializer(serializers.ModelSerializer):

    class Meta:
        model=Habit
        fields='__all__'

class HabitTransactionSerializer(serializers.ModelSerializer):

    class Meta:
        model=HabitTransaction
        fields='__all__'