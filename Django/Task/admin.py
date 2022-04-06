from django.contrib import admin

from Task.models import DietTransaction, FitnessTransaction, ImplementTransaction, StudyTransaction

# Register your models here.
admin.site.register(FitnessTransaction)
admin.site.register(DietTransaction)
admin.site.register(StudyTransaction)
admin.site.register(ImplementTransaction)