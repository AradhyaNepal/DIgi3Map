import imp
from django.urls import path
from .views import collectTrophy,getUserTrophy,collectEffect,getUserAllEffects,activateEffect,getUserActivatedEffects
urlpatterns = [
    path('collectUserTrophy/<int:leaderboard_id>/',collectTrophy ),
    path('getUserTrophy/',getUserTrophy),
    path('buyEffect/<int:effectId>/',collectEffect),
    path('getUserAllEffects/',getUserAllEffects),
    path('getUserActivatedEffects/',getUserActivatedEffects),
    path('activateEffect/<int:userEffect_id>/',activateEffect)
]