from django.urls import URLPattern, path,include
from .views import domain_detail, domain_list,user_domain,domain_habits 

urlpatterns=[
    path('domains/',domain_list),
    path('domains/<int:pk>/',domain_detail),
    
    path('domainHabits/<int:pk>/',domain_habits),
    path('userDomains/<int:user_id>/',user_domain)
] 
