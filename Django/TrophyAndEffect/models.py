from datetime import datetime
from statistics import mode
from django.db import models
from django.contrib.auth import get_user_model

# Create your models here.

class Trophy(models.Model):
    user_id=models.ForeignKey(get_user_model(),on_delete=models.CASCADE)
    count=models.IntegerField()

    def __str__(self):
        return str(self.user_id)+": "+str(self.count)

class Effect(models.Model):
    name=models.CharField(max_length=100)
    requiredTrophy=models.IntegerField()

    def __str__(self):
        return self.name

class UserTrophy(models.Model):
    user_id=models.ForeignKey(get_user_model(),on_delete=models.CASCADE)
    effect_id=models.ForeignKey(Effect,on_delete=models.CASCADE)
    activatedDate=models.DateField(null=True,blank=True)

    def __str__(self):
        return str(self.user_id)+": "+str(self.activatedDate)