# Generated by Django 3.2.4 on 2022-01-31 00:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('animalfav', '0004_auto_20220130_1940'),
    ]

    operations = [
        migrations.AddField(
            model_name='recorrido',
            name='dia',
            field=models.CharField(default='none', max_length=40),
        ),
    ]
