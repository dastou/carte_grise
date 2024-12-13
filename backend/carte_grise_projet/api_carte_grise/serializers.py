from rest_framework import serializers
from .models import Proprietaire, Vehicule

class ProprietaireSerializer(serializers.ModelSerializer):
    class Meta:
        model = Proprietaire
        fields = '__all__'

class VehiculeSerializer(serializers.ModelSerializer):
    proprietaire = ProprietaireSerializer()
    
    class Meta:
        model = Vehicule
        fields = '__all__'