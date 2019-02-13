import json
import csv
import sys
import operator
import urllib.request    
from datetime import datetime
from os import listdir,remove
from os.path import isfile,join,dirname,realpath

#Chargement de la configuration du script
with open("{}/config.json".format(dirname(realpath(__file__)))) as f:
    data = json.load(f)

#Liste des fichiers à traiter
chemin_chargement = data['formulaire.app.chemin.chargement.fichiers']
clef_api = data['formulaire.app.clef.api']
url_api = data['formulaire.app.url.api']

def lister_fichiers(chemin_chargement):
    fichiers = [f for f in listdir(chemin_chargement) if isfile(join(chemin_chargement, f))]
    return fichiers

#Analyse le fichier pour extraire les informations
def analyser_fichier(chemin_chargement, fichier):
    departement={}
    compte_population=0
    compte_nombre_hotels=0
    communes={}
    with open('{}/{}'.format(chemin_chargement, fichier), encoding='utf-8') as csvfile:
        csvreader = csv.DictReader(csvfile, delimiter=',', quotechar='"')
        for ligne in csvreader:
            departement['code']=ligne['DEP']
            compte_population = compte_population + int(ligne['Population'])
            compte_nombre_hotels = compte_nombre_hotels + int(ligne['Nb Hotel'])
            communes[ligne['LIBGEO']] = int(ligne['Population'])
    
    departement['population'] = compte_population
    departement['nombreHotel'] = compte_nombre_hotels
    departement['communePlusGrande'] = max(communes.items(), key=operator.itemgetter(1))[0]
    departement['communePlusPetite'] = min(communes.items(), key=operator.itemgetter(1))[0]

    return departement

#Appelle l'API pour mettre a jour la base de données
def insere_departement(fichier, url, departement):
    response = None
    try:
        req = urllib.request.Request(url)
        req.add_header('Content-Type', 'application/json; charset=utf-8')
        jsondata = json.dumps(departement)
        jsondataasbytes = jsondata.encode('utf-8')
        req.add_header('Content-Length', len(jsondataasbytes))
        response=urllib.request.urlopen(req, jsondataasbytes)
    except urllib.error.URLError as err:
        print("Erreur inattendue:", err.reason)
        return False
    if response.status == 200:
        return True
    else:
        println(response.reason)
        return False

liste_fichiers=lister_fichiers(chemin_chargement)
if len(liste_fichiers) == 0:
    print(u"{} - Aucun fichier trouvé".format(datetime.now()))
    exit(1)

for fichier in liste_fichiers:
    departement = analyser_fichier(chemin_chargement, fichier)
    remove(chemin_chargement+"/"+fichier)
    if not insere_departement(fichier, url_api + "/" + fichier + "/" +clef_api, departement):
        print(u"{} - Impossible de poster le fichier {}".format(datetime.now(), fichier))
    else:
        print(u"{} - Fichier {} posté avec succès".format(datetime.now(), fichier))
