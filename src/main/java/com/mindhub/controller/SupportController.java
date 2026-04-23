package com.mindhub.controller;

import com.mindhub.model.Appointment;
import com.mindhub.model.User;
import com.mindhub.service.SupportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.sql.Date;

/**
 * SupportController — professional directory and appointment booking.
 */
@Controller
public class SupportController {

    @Autowired
    private SupportService supportService;

    @GetMapping("/support")
    public String directory(Model model) {
        model.addAttribute("professionals", supportService.getProfessionals());
        return "support-directory";
    }

    @GetMapping("/support/book/{professionalId}")
    public String bookingForm(@PathVariable int professionalId, Model model) {
        model.addAttribute("professional", supportService.getProfessionalById(professionalId));
        return "booking";
    }

    @PostMapping("/support/book")
    public String bookAppointment(@RequestParam int professionalId,
                                  @RequestParam String appointmentDate,
                                  @RequestParam String timeSlot,
                                  @RequestParam(required = false) String notes,
                                  HttpSession session, RedirectAttributes ra) {
        User user = (User) session.getAttribute("loggedInUser");
        Appointment appt = new Appointment();
        appt.setUserId(user.getId());
        appt.setProfessionalId(professionalId);
        appt.setAppointmentDate(Date.valueOf(appointmentDate));
        appt.setTimeSlot(timeSlot);
        appt.setNotes(notes);
        supportService.bookAppointment(appt);
        ra.addFlashAttribute("success", "Appointment booked successfully!");
        return "redirect:/support/appointments";
    }

    @GetMapping("/support/appointments")
    public String myAppointments(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        model.addAttribute("appointments", supportService.getUserAppointments(user.getId()));
        return "appointments";
    }

    @PostMapping("/support/cancel/{id}")
    public String cancelAppointment(@PathVariable int id, RedirectAttributes ra) {
        supportService.cancelAppointment(id);
        ra.addFlashAttribute("success", "Appointment cancelled");
        return "redirect:/support/appointments";
    }
}

