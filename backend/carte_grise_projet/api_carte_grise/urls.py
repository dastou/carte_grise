from django.urls import path
from . import views

urlpatterns = [
    path('vehicule/<str:plaque>/', views.vehicule_detail, name='vehicule-detail'),
]