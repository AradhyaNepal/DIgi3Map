from statistics import mode
from django.db import models
from django.contrib.auth.models import User
from domain.models import Domain

from django.contrib.auth import get_user_model


# Create your models here.
class Habit(models.Model):
     #id=
    # user_id=models.ForeignKey(User, on_delete=models.CASCADE,default="")
    name=models.CharField(max_length=100)
    domain_id=models.ForeignKey(Domain, on_delete=models.CASCADE)
    photo_url=models.ImageField(upload_to='images/')
    widget_type=models.CharField(max_length=50)
    description=models.CharField(max_length=250)
    progress=models.IntegerField(default=0)
    time=models.IntegerField(null=True,blank=True)
    sets=models.IntegerField(null=True,blank=True)
    rest=models.IntegerField(null=True,blank=True)

    def __str__(self):
        return self.name


class HabitTransaction(models.Model):
    habitId=models.ForeignKey(Habit,on_delete=models.CASCADE)
    completed_date=models.DateField()
    userId=models.ForeignKey(get_user_model(),on_delete=models.CASCADE)
    def __str__(self):
        return str(self.completed_date)