import imp
from django.urls import path

from Task.views import RandomTaskDetailView, RandomTaskView, addDietTransaction, addFitnessTransaction, addImplementingTransaction, addLearningTransaction, getExcludedDiet, getExcludedFitness, getExcludedImplementing, getExcludedLearning
urlpatterns = [
    path('getExcludedFitness/',getExcludedFitness),
    path('addFitnessTransaction/',addFitnessTransaction),
    path('getExcludedDiet/',getExcludedDiet),
    path('addDietTransaction/',addDietTransaction),
    path('getExcludedLearningV2/',getExcludedLearning),
    path('addLearningTransaction/',addLearningTransaction),
    path('getExcludedImplementing/',getExcludedImplementing),
    path('randomTask/',RandomTaskView.as_view()),
    path('randomTask/<int:task_id>/',RandomTaskDetailView.as_view()),
    path('addImplementingTransaction/',addImplementingTransaction),
]

