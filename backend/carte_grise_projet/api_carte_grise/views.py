from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Vehicule
from .serializers import VehiculeSerializer

@api_view(['GET'])
def vehicule_detail(request, plaque):
    try:
        vehicule = Vehicule.objects.get(plaque=plaque)
        serializer = VehiculeSerializer(vehicule)
        return Response(serializer.data)
    except Vehicule.DoesNotExist:
        return Response({'error': 'Véhicule non trouvé'}, status=404)