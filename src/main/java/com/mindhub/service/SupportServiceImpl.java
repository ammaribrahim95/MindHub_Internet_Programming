package com.mindhub.service;

import com.mindhub.dao.AppointmentDao;
import com.mindhub.dao.ProfessionalDao;
import com.mindhub.model.Appointment;
import com.mindhub.model.Professional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SupportServiceImpl implements SupportService {

    @Autowired
    private ProfessionalDao professionalDao;

    @Autowired
    private AppointmentDao appointmentDao;

    @Override
    public List<Professional> getProfessionals() { return professionalDao.findAll(); }

    @Override
    public Professional getProfessionalById(int id) { return professionalDao.findById(id); }

    @Override
    public void bookAppointment(Appointment appointment) {
        if (appointment.getStatus() == null) appointment.setStatus("PENDING");
        appointmentDao.save(appointment);
    }

    @Override
    public List<Appointment> getUserAppointments(int userId) { return appointmentDao.findByUserId(userId); }

    @Override
    public void cancelAppointment(int appointmentId) { appointmentDao.updateStatus(appointmentId, "CANCELLED"); }
}

