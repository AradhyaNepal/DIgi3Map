from statistics import mode
from tkinter import CASCADE
from django.db import models
from habit.models import Habit
# Create your models here.
class Chain(models.Model):
    collected_date=models.DateField()
    habit_id=models.ForeignKey(Habit,on_delete=models.CASCADE)
    
    def __str__(self):
        return str(self.collected_date)
