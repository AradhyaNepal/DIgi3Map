from django.urls import URLPattern, path,include
from . import views
from knox import views as knox_view

urlpatterns=[
    path('login/',views.login_api),
    path('user/<int:pk>/',views.get_user_data),
    path('register/',views.register_api),
    path('logout/',knox_view.LogoutView.as_view()),
    
    path('changepass/',views.ChangePasswordView.as_view()),
    path('logoutall/',knox_view.LogoutAllView.as_view()),
    path('password_reset/', include('django_rest_passwordreset.urls', namespace='password_reset')),
]
