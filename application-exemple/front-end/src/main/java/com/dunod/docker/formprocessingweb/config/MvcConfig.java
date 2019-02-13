package com.dunod.docker.formprocessingweb.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MvcConfig implements WebMvcConfigurer {

    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("home");
        registry.addViewController("/home").setViewName("home");
        registry.addViewController("/app_menu").setViewName("app_menu");
        registry.addViewController("/login").setViewName("login");
        registry.addViewController("/formulaire_chargement").setViewName("formulaire_chargement");
    }
}