import imp
from django.urls import path

from Task.views import addDietTransaction, addFitnessTransaction, addImplementingTransaction, addLearningTransaction, getExcludedDiet, getExcludedFitness, getExcludedImplementing, getExcludedLearning
urlpatterns = [
    path('getExcludedFitness/',getExcludedFitness),
    path('addFitnessTransaction/',addFitnessTransaction),
    path('getExcludedDiet/',getExcludedDiet),
    path('addDietTransaction/',addDietTransaction),
    path('getExcludedLearning/',getExcludedLearning),
    path('addLearningTransaction/',addLearningTransaction),
    path('getExcludedImplementing/',getExcludedImplementing),
    path('addImplementingTransaction/',addImplementingTransaction),
]