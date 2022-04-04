from django.urls import path

from GroupPortal.chat_view import sendMessage
from .views import LeaderboardApi,UnCollectedLeaderboardApi
from GroupPortal.chat_view import getMessage,sendMessage
urlpatterns=[
    path('getLeaderboard/<int:user_id>/',LeaderboardApi.as_view()),
    path('getUncollectedLeaderboard/<int:user_id>/',UnCollectedLeaderboardApi.as_view()),
    path('getMessage/<int:leaderboard_id>/',getMessage),
    path('sendMessage/',sendMessage),
] 