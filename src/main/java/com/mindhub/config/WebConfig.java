package com.mindhub.config;

import com.mindhub.interceptor.AdminInterceptor;
import com.mindhub.interceptor.AuthInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

/**
 * Spring MVC configuration — replaces the traditional dispatcher-servlet.xml.
 * Configures view resolver, static resources, and interceptors.
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.mindhub")
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private AuthInterceptor authInterceptor;

    @Autowired
    private AdminInterceptor adminInterceptor;

    /**
     * JSP View Resolver — resolves view names to /WEB-INF/views/*.jsp
     */
    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setViewClass(JstlView.class);
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        return resolver;
    }

    /**
     * Static resource handlers — serve CSS, JS, assets, and Stitch UI files.
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/css/**")
                .addResourceLocations("/css/");
        registry.addResourceHandler("/js/**")
                .addResourceLocations("/js/");
        registry.addResourceHandler("/assets/**")
                .addResourceLocations("/assets/");
        registry.addResourceHandler("/public/**")
                .addResourceLocations("/public/");
    }

    /**
     * Interceptors — enforce authentication and admin authorization.
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // Auth interceptor: protect all pages except login, register, and static resources
        registry.addInterceptor(authInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns(
                        "/login", "/register", "/logout",
                        "/css/**", "/js/**", "/assets/**", "/public/**"
                );

        // Admin interceptor: protect /admin/** routes
        registry.addInterceptor(adminInterceptor)
                .addPathPatterns("/admin/**");
    }
}

