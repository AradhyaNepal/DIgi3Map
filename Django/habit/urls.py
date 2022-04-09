from django.urls import URLPattern, path,include

from habit.views import HabitApiView, HabitDetailApiView, UserHabitApiView, addDomainHabitPoints, addHabitTransaction, getExcludedHabit

urlpatterns=[
    path('habit/',HabitApiView.as_view()),
    path('habit/<int:id>/',HabitDetailApiView.as_view()),
    path('userHabit/<int:user_id>/',UserHabitApiView.as_view()),
    path('addHabitTransaction/<int:oneForSucess>/',addHabitTransaction),
    path('getExcludedLearning/',getExcludedHabit),
    path('addDomainHabitPoints/<int:habitId>/',addDomainHabitPoints),
] 
