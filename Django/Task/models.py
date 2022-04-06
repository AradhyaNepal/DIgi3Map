from statistics import mode
from tkinter import CASCADE
from django.db import models

from django.contrib.auth import get_user_model
user=get_user_model()
# Create your models here.

  
class FitnessTransaction(models.Model):
    fitness_id=models.IntegerField()
    user_id=models.ForeignKey(user,on_delete=models.CASCADE)
    completed_date=models.DateField()

class DietTransaction(models.Model):
    diet_id=models.IntegerField()
    user_id=models.ForeignKey(user,on_delete=models.CASCADE)
    completed_date=models.DateField()

class StudyTransaction(models.Model):
    study_id=models.IntegerField()
    user_id=models.ForeignKey(user,on_delete=models.CASCADE)
    completed_date=models.DateField()

class ImplementTransaction(models.Model):
    implement_id=models.IntegerField()
    user_id=models.ForeignKey(user,on_delete=models.CASCADE)
    completed_date=models.DateField()