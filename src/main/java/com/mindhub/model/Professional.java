package com.mindhub.model;

import java.sql.Timestamp;

/**
 * Professional entity — counselor/therapist in the support directory.
 * Maps to the 'professionals' table.
 */
public class Professional {

    private int id;
    private String name;
    private String title;
    private String specialization;
    private String bio;
    private String photoUrl;
    private String email;
    private String phone;
    private String availableDays;
    private Timestamp createdAt;

    public Professional() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }
    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }
    public String getPhotoUrl() { return photoUrl; }
    public void setPhotoUrl(String photoUrl) { this.photoUrl = photoUrl; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAvailableDays() { return availableDays; }
    public void setAvailableDays(String availableDays) { this.availableDays = availableDays; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String[] getAvailableDaysArray() {
        if (availableDays == null || availableDays.isEmpty()) return new String[0];
        return availableDays.split(",");
    }
}

