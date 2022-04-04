from rest_framework import serializers

from auth_pg.serializer import UserImageSerializer, UserNameSerializer
from .models import Chat
class ChatSerializer(serializers.ModelSerializer):
   user_id=UserNameSerializer()
   class Meta:
        model=Chat
        fields="__all__"

class ChatCreateSerializer(serializers.ModelSerializer):
   class Meta:
        model=Chat
        fields="__all__"
        
