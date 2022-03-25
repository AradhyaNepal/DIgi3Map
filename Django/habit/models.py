from statistics import mode
from django.db import models
from django.contrib.auth.models import User
from domain.models import Domain

# Create your models here.
class Habit(models.Model):
     #id=
    # user_id=models.ForeignKey(User, on_delete=models.CASCADE,default="")
    name=models.CharField(max_length=100)
    domain_id=models.ForeignKey(Domain, on_delete=models.CASCADE,default="1")
    photo_url=models.ImageField(upload_to='images/')
    widget_type=models.CharField(max_length=50)
    description=models.CharField(max_length=250)
    progress=models.IntegerField(default=0)

    def __str__(self):
        return self.name