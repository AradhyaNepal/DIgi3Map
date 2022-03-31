from django.urls import path
from .views import LeaderboardApi
urlpatterns=[
    path('getLeaderboard/<int:user_id>/',LeaderboardApi.as_view()),
] 