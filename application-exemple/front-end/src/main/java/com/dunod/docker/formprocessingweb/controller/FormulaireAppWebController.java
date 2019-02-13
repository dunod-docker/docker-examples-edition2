package com.dunod.docker.formprocessingweb.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dunod.docker.formprocessingweb.service.FormulaireAppService;

/**
 * Le contrôleur qui gère l'interface graphique de l'application
 */
@Controller
public class FormulaireAppWebController {
	@Value("${formulaire.app.chemin.chargement.fichiers}")
	private String cheminChargementFichier;

	@Autowired
	private FormulaireAppService service;
	
	@GetMapping("/visualisation")
	public String visualisation(Model model) {
		model.addAttribute("fichiers", service.getListeDesFichiersEnAttente());
		model.addAttribute("departements", service.getDepartements());
		return "visualisation";
	}

	@PostMapping("/chargement")
	public String chargementFichier(@RequestParam("fichier") MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			Files.copy(file.getInputStream(), (new File(cheminChargementFichier, file.getOriginalFilename())).toPath(),
					StandardCopyOption.REPLACE_EXISTING);
			redirectAttributes.addFlashAttribute("flash_message",
					"Le fichier \"" + file.getOriginalFilename() + "\" a été chargé !");
		} catch (IOException e) {
			redirectAttributes.addFlashAttribute("flash_message",
					"WARNING: impossible de charger le fichier " + file.getOriginalFilename() + "!");
		}
		return "redirect:/app_menu";
	}
}
