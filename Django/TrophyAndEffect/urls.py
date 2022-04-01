import imp
from django.urls import path
from .views import collectTrophy,getUserTrophy,collectEffect
urlpatterns = [
    path('collectUserTrophy/<int:leaderboard_id>/',collectTrophy ),
    path('getUserTrophy/',getUserTrophy),
    path('buyEffect/<int:effectId>/',collectEffect)
]