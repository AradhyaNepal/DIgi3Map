from django.urls import URLPattern, path,include
from .views import domain_detail, domain_list 

urlpatterns=[
    path('domains/',domain_list),
    path('domains/<int:pk>/',domain_detail)
] 
