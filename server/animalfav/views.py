from django.http import JsonResponse
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.parsers import JSONParser
from animalfav.serializers import *


# @api_view(['GET'])
# def tipos_tienda(request):
#     if request.method == 'GET':
#         tipos_tienda = TipoTienda.objects.all()
#         tipos_tienda_serializer = TipoTiendaSerializer(tipos_tienda, many=True)
#         return JsonResponse(tipos_tienda_serializer.data, safe=False)


@api_view(['GET'])
def cupones(request):
    if request.method == 'GET':
        cupones = Cupon.objects.all()
        cupon_serializer = CuponSerializer(cupones, many=True)
        return JsonResponse(cupon_serializer.data, safe=False)


# @api_view(['GET'])
# def tipos_cupon(request):
#     if request.method == 'GET':
#         tipos_cupon = TipoCupon.objects.all()
#         tipos_cupon_serializer = TipoCuponSerializer(tipos_cupon, many=True)
#         return JsonResponse(tipos_cupon_serializer.data, safe=False)


# @api_view(['POST'])
# def cupon_generado(request, pk, tipo_cupon):
#     if request.method == 'POST':
#         cupon = Cupon.objects.get(pk=pk)
#         cupon_data = JSONParser().parse(request)
#         cupon_serializer = CuponGeneradoSerializer(data=cupon_data)
#
#         if cupon_serializer.is_valid():
#             cupon_serializer.save()
#             return JsonResponse(cupon_serializer.data, status=status.HTTP_201_CREATED)
#         else:
#             return JsonResponse(cupon_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
