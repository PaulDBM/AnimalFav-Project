
from rest_framework.routers import DefaultRouter

from animalfav import views

router = DefaultRouter()

router.register(r'^api/evento', views.EventoView)
router.register(r'^api/recorrido', views.RecorridoView)

urlpatterns = router.urls