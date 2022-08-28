from django.contrib import admin
from chain.models import Chain
from domain.models import Domain
from habit.models import Habit
from .models import Coin
# Register your models here.
admin.site.register(Coin)
admin.site.register(Habit)
admin.site.register(Chain)
admin.site.register(Domain)