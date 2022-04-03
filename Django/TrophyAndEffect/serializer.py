from rest_framework import serializers
from .models import Trophy,Effect,UserEffect

class TrophySerializer(serializers.ModelSerializer):
    class Meta:
        model=Trophy
        fields='__all__'

class EffectSerializer(serializers.ModelSerializer):
    class Meta:
        model=Effect
        fields='__all__'

class UserEffectSerializer(serializers.ModelSerializer):
    class Meta:
        model=UserEffect
        fields='__all__'