package com.dunod.docker.formprocessingweb.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	@Value("${formulaire.app.utilisateur.login}")
	private String login;
	@Value("${formulaire.app.utilisateur.mot_de_passe}")
	private String motDePasse;
	
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
        	.csrf().disable()
            .authorizeRequests()
                .antMatchers("/", "/home", "/test", "/insere_departement/**").permitAll()
                .anyRequest().authenticated()
                .and()
            .formLogin()
                .loginPage("/login")
                .permitAll()
                .and()
            .logout()
                .permitAll();
    }

    @Bean
    @Override
    public UserDetailsService userDetailsService() {
    	/*
    	 * Implémentation non sécurisée - ne pas utiliser pour un vrai site web
    	 */
        @SuppressWarnings("deprecation")
		UserDetails user =
             User.withDefaultPasswordEncoder()
                .username(login)
                .password(motDePasse)
                .roles("USER")
                .build();
        return new InMemoryUserDetailsManager(user);
    }
}