from django.conf.urls import url
from animalfav import views
from django.urls import path, include

urlpatterns = [
    url(r'^api/cupones$', views.cupones),
    url(r'^api/tipos_tienda$', views.tipos_tienda),
    url(r'^api/tipos_cupon$', views.tipos_cupon),
    url(r'^api/cupon_generado$', views.cupon_generado),
    url(r'^api/cupon/(?P<code>[0-9]+)$', views.canjeo_cupon),
    path('', include('animalfav.routes')),
]

