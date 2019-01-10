# Generated by Django 2.1.2 on 2019-01-10 01:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dscan', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Alliance',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('allianceID', models.BigIntegerField()),
                ('ticker', models.TextField()),
                ('name', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='Corporation',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('corporationID', models.BigIntegerField()),
                ('ticker', models.TextField()),
                ('name', models.TextField()),
            ],
        ),
    ]