from rest_framework import serializers

import domain
from .models import Habit

class HabitSerializer(serializers.ModelSerializer):

    class Meta:
        model=Habit
        fields='__all__'