from re import I
from django.contrib import admin
from .models import Chat, Leaderboard,LeaderboardPlayers
# Register your models here.
admin.site.register(Leaderboard)
admin.site.register(LeaderboardPlayers)
admin.site.register(Chat)