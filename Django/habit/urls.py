from django.urls import URLPattern, path,include

from habit.views import HabitApiView, HabitDetailApiView, UserHabitApiView

urlpatterns=[
    path('habit/',HabitApiView.as_view()),
    path('habit/<int:id>/',HabitDetailApiView.as_view()),
    path('userHabit/<int:user_id>/',UserHabitApiView.as_view())
] 
