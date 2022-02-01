from django.db import models


class TipoTienda(models.Model):
    nombre = models.CharField(verbose_name="nombre", max_length=255, default='')
    descripcion = models.CharField(verbose_name="descripcion", max_length=255, default='')

    class Meta:
        db_table = 'tipo_tienda'


class Cupon(models.Model):
    nombre = models.CharField(verbose_name="nombre", max_length=255, default='')
    expiracion = models.DateTimeField(verbose_name="expiracion", null=True)
    tipo_tienda = models.ForeignKey(TipoTienda, verbose_name="tipo_tienda", null=True, on_delete=models.RESTRICT)
    class Meta:
        db_table = 'cupon'


class TipoCupon(models.Model):
    nombre = models.CharField(verbose_name="nombre", max_length=255, default='')

    class Meta:
        db_table = 'tipo_cupon'


class CuponGenerado(models.Model):
    canjeado = models.BooleanField(verbose_name="canjeado", default=False)
    codigo = models.CharField(verbose_name="codigo", max_length=255, default='')
    expiracion = models.DateTimeField(verbose_name="expiracion", null=True)
    fecha_canjeo = models.DateTimeField(verbose_name="fecha_canjeo", null=True)
    cupon =  models.ForeignKey(Cupon, verbose_name="cupon", null=True, on_delete=models.RESTRICT)
    tipo_cupon = models.ForeignKey(TipoCupon, verbose_name="tipo_cupon", null=True, on_delete=models.RESTRICT)
    class Meta:
        db_table = 'cupon_generado'

class Evento(models.Model):
    nombre = models.CharField(max_length=50)
    correo = models.CharField(max_length=40)
    dia = models.CharField(max_length=40)
    duracion = models.CharField(max_length=30)
    ubicacion = models.CharField(max_length=100)

class Recorrido(models.Model):
    nombre = models.CharField(max_length=50)
    correo = models.CharField(max_length=40)
    dia = models.CharField(max_length=40, default="none")
    duracion = models.CharField(max_length=30)
    ubicacion = models.CharField(max_length=100)
    descRecorrido = models.CharField(max_length=100)