from statistics import mode
from django.db import models
from django.contrib.auth import get_user_model
# Create your models here.
class Coin(models.Model):
    user_id=models.ForeignKey(get_user_model(), on_delete=models.CASCADE)
    amount=models.IntegerField()
    remark=models.CharField(max_length=100)
    dateCollected=models.DateField()
    
    def __str__(self):
        return self.remark
