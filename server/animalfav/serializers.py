from rest_framework import serializers
from .models import *


#class TipoTiendaSerializer(serializers.ModelSerializer):
#    class Meta:
#        model = TipoTienda
#        fields = '__all__'


class CuponSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cupon
        fields = '__all__'


class TipoCuponSerializer(serializers.ModelSerializer):
   class Meta:
       model = TipoCupon
       fields = '__all__'


#class CuponGeneradoSerializer(serializers.ModelSerializer):
#    class Meta:
#        model = CuponGenerado
#        fields = '__all__'

class EventoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Evento
        fields = '__all__'
    
    def create(self, data):
        newEvento = Evento.objects.create(
            nombre = data.get("nombre"),
            correo = data.get("correo"),
            dia = data.get("dia"),
            duracion = data.get("duracion"),
            ubicación = data.get("ubicación")
        )

        return newEvento


class RecorridoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recorrido
        fields = '__all__'
    
    def create(self, data):
        newRecorrido = Recorrido.objects.create(
            nombre = data.get("nombre"),
            correo = data.get("correo"),
            dia = data.get("dia"),
            duracion = data.get("duracion"),
            ubicación = data.get("ubicación"),
            descRecorrido = data.get("descRecorrido")
        )

        return newRecorrido