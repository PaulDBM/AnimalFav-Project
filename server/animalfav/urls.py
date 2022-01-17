from django.conf.urls import url
from animalfav import views
from django.urls import path, include

urlpatterns = [
    url(r'^api/cupones', views.cupones),
    # url(r'^api/cupon_generado/(?P<pk>[0-9]+)$', views.cupon_generado),
    path('', include('animalfav.routes')),
]

