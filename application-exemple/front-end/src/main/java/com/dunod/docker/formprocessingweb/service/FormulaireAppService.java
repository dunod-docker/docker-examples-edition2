package com.dunod.docker.formprocessingweb.service;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Component;

import com.dunod.docker.formprocessingweb.dto.Departement;
import com.dunod.docker.formprocessingweb.dto.Fichier;

/**
 * Le module qui héberge la logique d'accès aux données
 */
@Component
public class FormulaireAppService {
	@Value("${formulaire.app.chemin.chargement.fichiers}")
	private String cheminChargementFichier;
	
	@Autowired
	private JdbcTemplate template;
	
	/**
	 * Insère in département dans la base de donnée
	 * @param departement un objet departement
	 */
	public void insereDepartement(final Departement departement) {
		template.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection conn) throws SQLException {
				PreparedStatement pstmt=conn.prepareStatement(
						"REPLACE into departement (code,population,nombre_hotel,commune_plus_grande,commune_plus_petite,last_update)"
						+ " values(?,?,?,?,?,NOW())");
				pstmt.setString(1, departement.getCode());
				pstmt.setInt(2, departement.getPopulation());
				pstmt.setInt(3, departement.getNombreHotel());
				pstmt.setString(4, departement.getCommunePlusGrande());
				pstmt.setString(5, departement.getCommunePlusPetite());
				return pstmt;
			}
		});
	}
	
	/**
	 * Retourne la liste des fichiers en attente de traitement
	 * @retun une liste de fichiers
	 */
	public List<Fichier> getListeDesFichiersEnAttente() {
		List<Fichier> listeDeFichiers=new ArrayList<>();
		File repertoire=new File(cheminChargementFichier);
		for(File fichier : repertoire.listFiles()) {
			listeDeFichiers.add(new Fichier(fichier));
		}
		listeDeFichiers.sort((f1, f2) -> f1.getDerniereModification().compareTo(f2.getDerniereModification()));
		return listeDeFichiers;
	}
	
	/**
	 * Retourne la liste des départements extraite de la base de données
	 * @retun une liste de départements
	 */
	public List<Departement> getDepartements() {
		List<Departement> listeDeDepartements=template.query(
			"SELECT code,population,nombre_hotel,commune_plus_grande,commune_plus_petite,last_update FROM departement order by code", 
			new ResultSetExtractor<List<Departement>>() {
				@Override
				public List<Departement> extractData(ResultSet rs) throws SQLException, DataAccessException {
					List<Departement> listeDeDepartements=new ArrayList<>();
					while(rs.next()) {
						Departement departement=new Departement();
						departement.setCode(rs.getString("code"));
						departement.setCommunePlusGrande(rs.getString("commune_plus_grande"));
						departement.setCommunePlusPetite(rs.getString("commune_plus_petite"));
						departement.setNombreHotel(rs.getInt("nombre_hotel"));
						departement.setPopulation(rs.getInt("population"));
						departement.setLastUpdate(rs.getTimestamp("last_update"));
						listeDeDepartements.add(departement);
					}
					return listeDeDepartements;
				}
		});
		return listeDeDepartements;
	}
}
