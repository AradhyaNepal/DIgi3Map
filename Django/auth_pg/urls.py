from django.urls import URLPattern, path,include
from . import views
from knox import views as knox_view

urlpatterns=[
    path('login/',views.login_api),
    path('user/<int:pk>/',views.get_user_data),
    path('register/',views.register_api),
    path('userProfile/',views.getUserProfile),
    path('updateWorkout/<int:oneForYes>/',views.updateWorkout),
    path('updateDiet/<int:oneForYes>/',views.updateDiet),
    path('updateLearning/<int:oneForYes>/',views.updateLearning),
    path('updateImplementing/<int:oneForYes>/',views.updateImplementing),
    path('updateImage/',views.updateImage),
    path('logout/',knox_view.LogoutView.as_view()),
    path('userProgressUpdate/<int:id>/',views.update_user),
    path('changepass/',views.ChangePasswordView.as_view()),
    path('logoutall/',knox_view.LogoutAllView.as_view()),
    path('password_reset/', include('django_rest_passwordreset.urls', namespace='password_reset')),
]
