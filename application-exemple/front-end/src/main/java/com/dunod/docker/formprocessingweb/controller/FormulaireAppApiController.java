package com.dunod.docker.formprocessingweb.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.dunod.docker.formprocessingweb.dto.Departement;
import com.dunod.docker.formprocessingweb.service.FormulaireAppService;

/**
 * Le controlleur qui expose une API pour mettre a jour la base de donnée avec 
 * les données extraites d'un fichier
 */
@RestController
public class FormulaireAppApiController {
	private static final Logger LOGGER =
			LoggerFactory.getLogger(FormulaireAppApiController.class);
	
	@Value("${formulaire.app.clef.api}")
	private String clefApi;
	
	@Autowired
	private FormulaireAppService service;
	
	@PostMapping(value = "/insere_departement/{nom_fichier}/{clef}")
    public ResponseEntity<String> insereDepartement(
    		@PathVariable(value="nom_fichier") String nomDuFichier,
    		@PathVariable(value="clef") String clef,
    		@RequestBody Departement departement) {
    	LOGGER.info("Tentative de mise a jour avec les données du fichier "+nomDuFichier);
    	if(!clefApi.equals(clef)) {
    		return new ResponseEntity<String>("Clef d'API incorrecte",HttpStatus.UNAUTHORIZED);
    	}
    	try {
    		service.insereDepartement(departement);
    	}catch(Exception e) {
    		LOGGER.error("Erreur lors de la mise a jour de la base de données",e);
    		return new ResponseEntity<String>("Exception : "+e.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
    	}
        return new ResponseEntity<String>("OK",HttpStatus.OK);
    }
}
