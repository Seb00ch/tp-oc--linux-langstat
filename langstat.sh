#!/bin/bash

#--------------------------
#       langstat.sh
#--------------------------
# Ce script fournit des statistiques sur l'utilisation des lettres dans une langue.
# 1er argument: Chemin et nom du dictionnaire.
# 2ème argument: "r", indique au script de faire la fonction inverse.

#--------------------------
# 1. Pour chaque lettre de l'alphabet, on compte le nombre de mots qui contient chaque lettre dans l'ordre décroissant.
# 2. Lorsque le 2ème argument est présent, on compte le nombre de mots qui ne contiennent pas chaque lettre dans l'ordre décroissant.
#--------------------------

# Variables
alphabet=("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")
tempFile="temp_file"
flag="i"

# Teste l'existence du fichier renseigné et du 1er paramètre
if [ ! -z $1 ] && [ -e $1 ]; then
  echo "------------------------------------------------------"
  echo "Bienvenue dans l'outil de statistiques de dictionnaire"
  echo "------------------------------------------------------"
  echo "Analyse en cours sur le fichier \"$1\"..."
  
  # Teste l'existence d'un 2ème paramètre
  if [[ $2 = "r" ]]; then
    echo "Comptage du nombre de mots qui n'ont pas chaque lettre de l'alphabet"
    flag="v"
  else
    echo "Comptage du nombre de mots qui possède chaque lettre de l'alphabet"
  fi

  # Création d'un fichier temporaire
  touch $tempFile

  # Pour chaque lettre de l'alphabet, on compte le nombre de mots qui contient la lettre en cours
  for lettre in ${alphabet[@]}; do
    # On compte le nombre de mots qui ont ou n'ont pas la lettre en cours ( en fontion du 2ème paramètre )
    nombre=`grep -$flag $lettre $1 | wc -l`
    # On écrit le résultat dans le fichier temporaire
    echo -e "$nombre - $lettre" >> $tempFile
  done

  # Trie et affichage du fichier temporaire
  echo ""
  sort -rn $tempFile

  # Suppression du fichier temporaire
  rm -f $tempFile
else
  # Affichage d'un message d'erreur si le 1er argument est manquant ou que le fichier est inexistant
  echo "Veuillez indiquer au moins un argument valide, soit un fichier existant."
fi