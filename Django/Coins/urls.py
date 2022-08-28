from django.urls import URLPattern, path,include
from . import views
from .views import CoinAPIViews,CoinUserViews

urlpatterns=[
    path('coin/',CoinAPIViews.as_view()),
    path('userCoins/<int:id>/',CoinUserViews.as_view()),
]
