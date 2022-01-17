# Generated by Django 3.2.4 on 2022-01-17 01:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('animalfav', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Evento',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nombre', models.CharField(max_length=50)),
                ('correo', models.CharField(max_length=40)),
                ('dia', models.DateTimeField()),
                ('duracion', models.CharField(max_length=30)),
                ('ubicación', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Recorrido',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nombre', models.CharField(max_length=50)),
                ('correo', models.CharField(max_length=40)),
                ('dia', models.DateTimeField()),
                ('duracion', models.CharField(max_length=30)),
                ('ubicación', models.CharField(max_length=100)),
                ('descRecorrido', models.CharField(max_length=100)),
            ],
        ),
    ]