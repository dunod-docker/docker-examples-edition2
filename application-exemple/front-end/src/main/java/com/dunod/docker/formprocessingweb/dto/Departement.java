package com.dunod.docker.formprocessingweb.dto;

import java.util.Date;

/**
 * Un objet qui représente un département
 */
public class Departement {
	private String code;
	private int population;
	private String communePlusGrande;
	private String communePlusPetite;
	private int nombreHotel;
	private Date lastUpdate;
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public int getPopulation() {
		return population;
	}
	public void setPopulation(int population) {
		this.population = population;
	}
	public String getCommunePlusGrande() {
		return communePlusGrande;
	}
	public void setCommunePlusGrande(String communePlusGrande) {
		this.communePlusGrande = communePlusGrande;
	}
	public String getCommunePlusPetite() {
		return communePlusPetite;
	}
	public void setCommunePlusPetite(String communePlusPetite) {
		this.communePlusPetite = communePlusPetite;
	}
	public int getNombreHotel() {
		return nombreHotel;
	}
	public void setNombreHotel(int nombreHotel) {
		this.nombreHotel = nombreHotel;
	}
	public Date getLastUpdate() {
		return lastUpdate;
	}
	public void setLastUpdate(Date lastUpdate) {
		this.lastUpdate = lastUpdate;
	}
}
