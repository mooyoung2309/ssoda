# Generated by Django 3.2.5 on 2021-08-06 14:09

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0023_alter_reward_options'),
    ]

    operations = [
        migrations.AlterField(
            model_name='reward',
            name='event',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='rewards', to='api.event'),
        ),
        migrations.AlterField(
            model_name='reward',
            name='id',
            field=models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID'),
        ),
    ]