
from django.db import models

from django.contrib.auth import get_user_model
# Create your models here.
# Create your models here.
class Leaderboard(models.Model):
    #id=
    # user_id=models.ForeignKey(User, on_delete=models.CASCADE,default="")
    started_date=models.DateField()
    winner_id=models.ForeignKey(get_user_model(), on_delete=models.CASCADE,null=True,blank=True)
    trophy_collected=models.BooleanField(default=False)
    def __str__(self):
        return str(self.started_date)
        
class LeaderboardPlayers(models.Model):
    leaderboard_id=models.ForeignKey(Leaderboard, on_delete=models.CASCADE)
    player_id=models.ForeignKey(get_user_model(), on_delete=models.CASCADE)
    def __str__(self):
        return str(self.leaderboard_id)