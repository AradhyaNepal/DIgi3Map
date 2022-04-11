from re import I
from django.contrib import admin
from .models import Chat, Leaderboard,LeaderboardPlayers, ReportUser
# Register your models here.
admin.site.register(Leaderboard)
admin.site.register(LeaderboardPlayers)
admin.site.register(Chat)
admin.site.register(ReportUser)