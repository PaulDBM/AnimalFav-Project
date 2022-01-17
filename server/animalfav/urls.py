from django.conf.urls import url
from animalfav import views

urlpatterns = [
    url(r'^api/cupones', views.cupones),
    # url(r'^api/cupon_generado/(?P<pk>[0-9]+)$', views.cupon_generado),
]