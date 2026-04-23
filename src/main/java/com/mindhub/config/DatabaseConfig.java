package com.mindhub.config;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;

/**
 * Database configuration — sets up MySQL DataSource with connection pooling
 * and provides a JdbcTemplate bean for DAO layer.
 */
@Configuration
@PropertySource("classpath:database.properties")
public class DatabaseConfig {

    @Value("${db.driver}")
    private String driver;

    @Value("${db.url}")
    private String url;

    @Value("${db.username}")
    private String username;

    @Value("${db.password}")
    private String password;

    @Value("${db.pool.initialSize}")
    private int initialSize;

    @Value("${db.pool.maxTotal}")
    private int maxTotal;

    @Value("${db.pool.maxIdle}")
    private int maxIdle;

    @Value("${db.pool.minIdle}")
    private int minIdle;

    /**
     * DataSource bean with Apache DBCP2 connection pooling.
     */
    @Bean
    public DataSource dataSource() {
        BasicDataSource ds = new BasicDataSource();
        ds.setDriverClassName(driver);
        ds.setUrl(url);
        ds.setUsername(username);
        ds.setPassword(password);
        ds.setInitialSize(initialSize);
        ds.setMaxTotal(maxTotal);
        ds.setMaxIdle(maxIdle);
        ds.setMinIdle(minIdle);
        return ds;
    }

    /**
     * JdbcTemplate bean — used by all DAO implementations for database operations.
     */
    @Bean
    public JdbcTemplate jdbcTemplate(DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }
}

