from django.db import models
from TrophyAndEffect.models import Effect
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
        return str(self.id)
        
class LeaderboardPlayers(models.Model):
    leaderboard_id=models.ForeignKey(Leaderboard, on_delete=models.CASCADE)
    player_id=models.ForeignKey(get_user_model(), on_delete=models.CASCADE)
    def __str__(self):
        return str(self.leaderboard_id)


class Chat(models.Model):
    chat_effect=models.ForeignKey(Effect,on_delete=models.CASCADE,null=True,blank=True)
    time=models.DateTimeField()
    leaderboard_id=models.ForeignKey(Leaderboard,on_delete=models.CASCADE)
    user_id=models.ForeignKey(get_user_model(),on_delete=models.CASCADE)
    message=models.CharField(max_length=250)

class ReportUser(models.Model):
    leaderbaord_id=models.ForeignKey(Leaderboard,on_delete=models.CASCADE)
    reporter_id=models.ForeignKey(get_user_model(),on_delete=models.CASCADE,related_name="report_user_reporter_id")
    reported_user=models.ForeignKey(get_user_model(),on_delete=models.CASCADE,related_name="report_user_reported_user")
    reported_date=models.DateField()