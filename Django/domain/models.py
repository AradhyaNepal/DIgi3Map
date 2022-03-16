from django.db import models
from platformdirs import user_log_dir

from django.contrib.auth.models import User
# Create your models here.
class Domain(models.Model):
    
    name=models.CharField(max_length=100)
    photo_url=models.CharField(max_length=100)
    #user_id=models.ForeignKey(User, on_delete=models.CASCADE,default="5")
    description=models.CharField(max_length=250)
    priority=models.CharField(max_length=10)

    def __str__(self):
        return self.name