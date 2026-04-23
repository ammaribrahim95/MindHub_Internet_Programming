package com.mindhub.model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Appointment entity — booking with a professional.
 * Maps to the 'appointments' table.
 */
public class Appointment {

    private int id;
    private int userId;
    private int professionalId;
    private Date appointmentDate;
    private String timeSlot;
    private String status; // PENDING, CONFIRMED, CANCELLED, COMPLETED
    private String notes;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Transient
    private String professionalName;
    private String userName;

    public Appointment() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getProfessionalId() { return professionalId; }
    public void setProfessionalId(int professionalId) { this.professionalId = professionalId; }
    public Date getAppointmentDate() { return appointmentDate; }
    public void setAppointmentDate(Date appointmentDate) { this.appointmentDate = appointmentDate; }
    public String getTimeSlot() { return timeSlot; }
    public void setTimeSlot(String timeSlot) { this.timeSlot = timeSlot; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    public String getProfessionalName() { return professionalName; }
    public void setProfessionalName(String professionalName) { this.professionalName = professionalName; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
}

