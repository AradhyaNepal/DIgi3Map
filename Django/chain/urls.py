
from django.urls import path
from .views import ChainAddView,ChainAPIView,ChainCoinApi


urlpatterns = [
    path('addchain/', ChainAddView.as_view()),
    path('getChain/<int:habit_id>/', ChainAPIView.as_view()),
    path('getChainCoin/<int:habit_id>/', ChainCoinApi.as_view()),
]
