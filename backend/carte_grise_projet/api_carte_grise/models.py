from django.db import models

def get_proprietaire_image_choices():
    import os
    from django.conf import settings
    image_dir = os.path.join(settings.STATIC_ROOT, 'img', 'proprietaires')
    if os.path.exists(image_dir):
        return [(f'img/proprietaires/{f}', f) for f in os.listdir(image_dir) if f.endswith(('.jpg', '.jpeg', '.png'))]
    return []

def get_vehicule_image_choices():
    import os
    from django.conf import settings
    image_dir = os.path.join(settings.STATIC_ROOT, 'img', 'vehicules')
    if os.path.exists(image_dir):
        return [(f'img/vehicules/{f}', f) for f in os.listdir(image_dir) if f.endswith(('.jpg', '.jpeg', '.png'))]
    return []

class Proprietaire(models.Model):
    nom = models.CharField(max_length=100)
    prenom = models.CharField(max_length=100)
    telephone = models.CharField(max_length=20)
    adresse = models.TextField()
    photo = models.CharField(
        max_length=255,
        choices=get_proprietaire_image_choices,
        help_text="Sélectionnez une image du dossier static/img/proprietaires"
    )
    
    def __str__(self):
        return f"{self.nom} {self.prenom}"

class Vehicule(models.Model):
    proprietaire = models.OneToOneField(Proprietaire, on_delete=models.CASCADE)
    plaque = models.CharField(max_length=20, unique=True)
    marque = models.CharField(max_length=100)
    modele = models.CharField(max_length=100)
    photo = models.CharField(
        max_length=255,
        choices=get_vehicule_image_choices,
        help_text="Sélectionnez une image du dossier static/img/vehicules"
    )
    date_fin_assurance = models.DateField()
    date_controle_technique = models.DateField()
    poids = models.IntegerField()
    date_mise_circulation = models.DateField()
    type_moteur = models.CharField(max_length=50)
    puissance = models.CharField(max_length=50)
    transmission = models.CharField(max_length=50)
    consommation = models.CharField(max_length=50)
    
    def __str__(self):
        return f"{self.plaque} - {self.marque} {self.modele}"