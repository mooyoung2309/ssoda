# Generated by Django 3.2.5 on 2021-09-30 02:11

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0040_auto_20210930_0202'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='event',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='eventimages',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='hashtag',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='hashtaghashtags',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='hashtagrequirements',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='reward',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='store',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='storeimages',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='user',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='userrefreshtoken',
            options={'managed': False},
        ),
    ]