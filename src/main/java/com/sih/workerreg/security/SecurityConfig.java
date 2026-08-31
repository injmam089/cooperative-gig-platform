package com.sih.workerreg.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
        return authConfig.getAuthenticationManager();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .cors(cors -> cors.configurationSource(corsConfigurationSource()))
            .csrf(AbstractHttpConfigurer::disable)
            .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED))
            .authorizeHttpRequests(auth -> auth
                // Static UI resources
                .requestMatchers("/", "/index.html", "/style.css", "/app.js", "/favicon.ico", "/error").permitAll()
                
                // Public discovery & read endpoints
                .requestMatchers(HttpMethod.GET, "/api/services/**").permitAll()
                .requestMatchers(HttpMethod.GET, "/api/workers/**").permitAll()
                .requestMatchers(HttpMethod.GET, "/api/customers/**").permitAll()
                
                // Public authentication & OTP verification endpoints
                .requestMatchers("/api/auth/**").permitAll()
                
                // Public worker onboarding & login
                .requestMatchers(HttpMethod.POST, "/api/workers", "/api/workers/login", "/api/workers/logout").permitAll()
                
                // Public customer signup & login
                .requestMatchers(HttpMethod.POST, "/api/customers", "/api/customers/login", "/api/customers/logout", "/api/customers/send-otp", "/api/customers/verify-otp").permitAll()
                
                // Public admin login/logout
                .requestMatchers(HttpMethod.POST, "/api/admin/login", "/api/admin/logout").permitAll()
                
                // Service requests, bookings, admin, customers, AI, workforce, notifications & worker APIs are authorized at controller/session layer
                .requestMatchers("/api/service-requests/**", "/api/bookings/**", "/api/customers/**", "/api/admin/**", "/api/ai/**", "/api/workforce/**", "/api/notifications/**", "/api/workers/**").permitAll()
                
                // Any other API requires authentication
                .anyRequest().authenticated()

            );

        return http.build();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOriginPatterns(Arrays.asList(
            "http://localhost:*",
            "http://127.0.0.1:*",
            "http://192.168.*:*",
            "http://10.*:*",
            "http://172.16.*:*",
            "http://172.17.*:*",
            "http://172.18.*:*",
            "http://172.19.*:*",
            "http://172.20.*:*",
            "http://172.21.*:*",
            "http://172.22.*:*",
            "http://172.23.*:*",
            "http://172.24.*:*",
            "http://172.25.*:*",
            "http://172.26.*:*",
            "http://172.27.*:*",
            "http://172.28.*:*",
            "http://172.29.*:*",
            "http://172.30.*:*",
            "http://172.31.*:*",
            "https://*"
        ));
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(Arrays.asList("Authorization", "Content-Type", "X-Requested-With", "Accept", "Origin"));
        configuration.setAllowCredentials(true);
        configuration.setMaxAge(3600L);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
