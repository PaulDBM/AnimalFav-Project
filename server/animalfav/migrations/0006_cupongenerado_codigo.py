# Generated by Django 3.2.9 on 2022-02-01 04:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('animalfav', '0005_recorrido_dia'),
    ]

    operations = [
        migrations.AddField(
            model_name='cupongenerado',
            name='codigo',
            field=models.CharField(default='', max_length=255, verbose_name='codigo'),
        ),
    ]