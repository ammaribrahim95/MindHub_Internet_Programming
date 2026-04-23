package com.mindhub.dao;

import com.mindhub.model.Appointment;
import java.util.List;

public interface AppointmentDao {
    void save(Appointment appointment);
    List<Appointment> findByUserId(int userId);
    Appointment findById(int id);
    void updateStatus(int id, String status);
    void delete(int id);
    List<Appointment> findAll();
    int countAll();
}

