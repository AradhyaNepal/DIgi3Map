from rest_framework import serializers
from .models import Chain

class ChainSerialzier(serializers.ModelSerializer):
    class Meta:
        model=Chain
        fields='__all__' 