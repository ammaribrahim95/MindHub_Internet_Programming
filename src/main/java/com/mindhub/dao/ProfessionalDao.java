package com.mindhub.dao;

import com.mindhub.model.Professional;
import java.util.List;

public interface ProfessionalDao {
    List<Professional> findAll();
    Professional findById(int id);
    void save(Professional professional);
    void update(Professional professional);
    void delete(int id);
}

