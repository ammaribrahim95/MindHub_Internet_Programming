package com.mindhub.dao;

import com.mindhub.model.Appointment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AppointmentDaoImpl implements AppointmentDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Appointment> rowMapper = (rs, rowNum) -> {
        Appointment a = new Appointment();
        a.setId(rs.getInt("id"));
        a.setUserId(rs.getInt("user_id"));
        a.setProfessionalId(rs.getInt("professional_id"));
        a.setAppointmentDate(rs.getDate("appointment_date"));
        a.setTimeSlot(rs.getString("time_slot"));
        a.setStatus(rs.getString("status"));
        a.setNotes(rs.getString("notes"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        a.setUpdatedAt(rs.getTimestamp("updated_at"));
        return a;
    };

    @Override
    public void save(Appointment a) {
        jdbcTemplate.update(
                "INSERT INTO appointments (user_id, professional_id, appointment_date, time_slot, status, notes) VALUES (?,?,?,?,?,?)",
                a.getUserId(), a.getProfessionalId(), a.getAppointmentDate(), a.getTimeSlot(), a.getStatus(), a.getNotes());
    }

    @Override
    public List<Appointment> findByUserId(int userId) {
        String sql = "SELECT a.*, p.name AS professional_name FROM appointments a " +
                "JOIN professionals p ON a.professional_id = p.id WHERE a.user_id = ? ORDER BY a.appointment_date DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Appointment a = rowMapper.mapRow(rs, rowNum);
            a.setProfessionalName(rs.getString("professional_name"));
            return a;
        }, userId);
    }

    @Override
    public Appointment findById(int id) {
        List<Appointment> r = jdbcTemplate.query("SELECT * FROM appointments WHERE id = ?", rowMapper, id);
        return r.isEmpty() ? null : r.get(0);
    }

    @Override
    public void updateStatus(int id, String status) {
        jdbcTemplate.update("UPDATE appointments SET status = ? WHERE id = ?", status, id);
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM appointments WHERE id = ?", id);
    }

    @Override
    public List<Appointment> findAll() {
        String sql = "SELECT a.*, p.name AS professional_name, u.full_name AS user_name FROM appointments a " +
                "JOIN professionals p ON a.professional_id = p.id JOIN users u ON a.user_id = u.id ORDER BY a.appointment_date DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Appointment a = rowMapper.mapRow(rs, rowNum);
            a.setProfessionalName(rs.getString("professional_name"));
            a.setUserName(rs.getString("user_name"));
            return a;
        });
    }

    @Override
    public int countAll() {
        Integer c = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM appointments", Integer.class);
        return c != null ? c : 0;
    }
}

