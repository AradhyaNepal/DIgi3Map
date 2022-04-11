from dataclasses import fields
from pyexpat import model
from rest_framework import serializers

from auth_pg.serializer import UserImageSerializer, UserNameSerializer
from .models import Chat, ReportUser
class ChatSerializer(serializers.ModelSerializer):
   user_id=UserNameSerializer()
   class Meta:
        model=Chat
        fields="__all__"

class ChatCreateSerializer(serializers.ModelSerializer):
   class Meta:
        model=Chat
        fields="__all__"

class ReportUserSerializer(serializers.ModelSerializer):
   class Meta:
      model=ReportUser
      fields="__all__"
        
