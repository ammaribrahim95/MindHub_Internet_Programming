package com.mindhub.service;

import com.mindhub.model.Appointment;
import com.mindhub.model.Professional;
import java.util.List;

public interface SupportService {
    List<Professional> getProfessionals();
    Professional getProfessionalById(int id);
    void bookAppointment(Appointment appointment);
    List<Appointment> getUserAppointments(int userId);
    void cancelAppointment(int appointmentId);
}

