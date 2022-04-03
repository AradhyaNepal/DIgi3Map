from django.contrib.auth import get_user_model
from rest_framework import serializers, validators
class ChangePasswordSerializer(serializers.Serializer):
    model = get_user_model()
    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True)
class UserProgressSerializer(serializers.ModelSerializer):
    class Meta:
        model=get_user_model()
        fields=('workout_progress','diet_progress','learning_progress','implementing_progress')

class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model=get_user_model()
        fields=('id','userImage','username','email')

class UserImageSerializer(serializers.ModelSerializer):
    class Meta:
        model=get_user_model()
        fields=['userImage']
class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = get_user_model()
        fields = ("id","username", "password", "email","finess_points","carrer_points","workout_progress","diet_progress","learning_progress","implementing_progress")
        extra_kwargs = {
            "password": {"write_only": True},
            "email": {
                "required": True,
                "allow_blank": False,
                "validators": [
                    validators.UniqueValidator(
                        get_user_model().objects.all(), f"A user with that Email already exists."
                    )
                ],
            },
        }

    def create(self, validated_data):
        user = get_user_model().objects.create_user(
            username=validated_data["username"],
            email=validated_data["email"],
            password=validated_data["password"],
        )
        return user