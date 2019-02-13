package com.dunod.docker.formprocessingweb.dto;

import java.io.File;
import java.util.Date;

/**
 * Un objet qui représente un fichier à charger
 */
public class Fichier {
	private String nom;
	private Date derniereModification;
	
	public Fichier() {
	}
	
	public Fichier(File fichier) {
		super();
		this.nom = fichier.getName();
		this.derniereModification = new Date(fichier.lastModified());
	}
	
	public String getNom() {
		return nom;
	}
	
	public void setNom(String nom) {
		this.nom = nom;
	}
	
	public Date getDerniereModification() {
		return derniereModification;
	}

	public void setDerniereModification(Date derniereModification) {
		this.derniereModification = derniereModification;
	}
}
