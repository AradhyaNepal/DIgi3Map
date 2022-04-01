from rest_framework import serializers
from .models import Trophy,Effect,ActivatedTrophy

class TrophySerializer(serializers.ModelSerializer):
    class Meta:
        model=Trophy
        fields='__all__'

class EffectSerializer(serializers.ModelSerializer):
    class Meta:
        model=Effect
        fields='__all__'

class ActivatedTrophySerializer(serializers.ModelSerializer):
    class Meta:
        model=ActivatedTrophy
        fields='__all__'