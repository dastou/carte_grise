from django.contrib import admin
from .models import Proprietaire, Vehicule

@admin.register(Proprietaire)
class ProprietaireAdmin(admin.ModelAdmin):
    list_display = ('nom', 'prenom', 'telephone')
    search_fields = ('nom', 'prenom', 'telephone')

@admin.register(Vehicule)
class VehiculeAdmin(admin.ModelAdmin):
    list_display = ('plaque', 'marque', 'modele', 'proprietaire')
    search_fields = ('plaque', 'marque', 'modele')
    list_filter = ('marque',)