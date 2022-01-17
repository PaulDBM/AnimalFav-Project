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


#class TipoCuponSerializer(serializers.ModelSerializer):
#    class Meta:
#        model = TipoCupon
#        fields = '__all__'


#class CuponGeneradoSerializer(serializers.ModelSerializer):
#    class Meta:
#        model = CuponGenerado
#        fields = '__all__'
