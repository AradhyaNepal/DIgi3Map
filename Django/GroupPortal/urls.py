from django.urls import path
from .views import LeaderboardApi,UnCollectedLeaderboardApi
urlpatterns=[
    path('getLeaderboard/<int:user_id>/',LeaderboardApi.as_view()),
    
    path('getUncollectedLeaderboard/<int:user_id>/',UnCollectedLeaderboardApi.as_view()),
] 