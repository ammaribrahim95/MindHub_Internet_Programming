package com.mindhub.dao;

import com.mindhub.model.Professional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProfessionalDaoImpl implements ProfessionalDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Professional> rowMapper = (rs, rowNum) -> {
        Professional p = new Professional();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setTitle(rs.getString("title"));
        p.setSpecialization(rs.getString("specialization"));
        p.setBio(rs.getString("bio"));
        p.setPhotoUrl(rs.getString("photo_url"));
        p.setEmail(rs.getString("email"));
        p.setPhone(rs.getString("phone"));
        p.setAvailableDays(rs.getString("available_days"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        return p;
    };

    @Override
    public List<Professional> findAll() {
        return jdbcTemplate.query("SELECT * FROM professionals ORDER BY name", rowMapper);
    }

    @Override
    public Professional findById(int id) {
        List<Professional> r = jdbcTemplate.query("SELECT * FROM professionals WHERE id = ?", rowMapper, id);
        return r.isEmpty() ? null : r.get(0);
    }

    @Override
    public void save(Professional p) {
        jdbcTemplate.update("INSERT INTO professionals (name,title,specialization,bio,photo_url,email,phone,available_days) VALUES (?,?,?,?,?,?,?,?)",
                p.getName(), p.getTitle(), p.getSpecialization(), p.getBio(), p.getPhotoUrl(), p.getEmail(), p.getPhone(), p.getAvailableDays());
    }

    @Override
    public void update(Professional p) {
        jdbcTemplate.update("UPDATE professionals SET name=?,title=?,specialization=?,bio=?,photo_url=?,email=?,phone=?,available_days=? WHERE id=?",
                p.getName(), p.getTitle(), p.getSpecialization(), p.getBio(), p.getPhotoUrl(), p.getEmail(), p.getPhone(), p.getAvailableDays(), p.getId());
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM professionals WHERE id = ?", id);
    }
}

