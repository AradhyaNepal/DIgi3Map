from django.db import models
from platformdirs import user_log_dir

from django.contrib.auth.models import User
# Create your models here.
class Domain(models.Model):
    
    name=models.CharField(max_length=100)
    photo_url=models.ImageField(upload_to='images/')
    
    user_id=models.ForeignKey(User, on_delete=models.CASCADE)
    description=models.CharField(max_length=250)
    percentage=models.IntegerField(max_length=5,default=25)
    priority=models.CharField(max_length=10)

    def __str__(self):
        return self.name