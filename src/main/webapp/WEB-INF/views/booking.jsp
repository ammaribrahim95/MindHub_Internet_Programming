<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub — Book Session</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="support" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar">
        <div style="display:flex;align-items:center;gap:1rem;">
            <a href="${pageContext.request.contextPath}/support" class="btn btn-outline" style="padding:0.4rem;border-radius:50%;"><span class="material-symbols-outlined">arrow_back</span></a>
            <h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">Book a Session</h1>
        </div>
    </div>
    <div class="page-content" style="display:grid;grid-template-columns:1fr 2fr;gap:2rem;max-width:1000px;">
        
        <!-- Professional Profile -->
        <div class="card" style="align-self:start;text-align:center;">
            <img src="${professional.photoUrl}" alt="${professional.name}" style="width:6rem;height:6rem;border-radius:50%;object-fit:cover;border:3px solid var(--primary-container);margin-bottom:1rem;"/>
            <h3 style="font-size:1.25rem;">${professional.name}</h3>
            <p style="font-size:0.9rem;color:var(--primary);font-weight:600;margin-bottom:1rem;">${professional.title}</p>
            <div style="text-align:left;font-size:0.8rem;color:var(--on-surface-variant);display:flex;flex-direction:column;gap:0.5rem;background:var(--bg-container);padding:1rem;border-radius:var(--radius-md);">
                <p><strong>Specializes in:</strong><br/>${professional.specialization}</p>
                <p><strong>Availability:</strong><br/>${professional.availableDays}</p>
            </div>
        </div>

        <!-- Booking Form -->
        <div class="card">
            <h3 style="margin-bottom:1.5rem;font-family:var(--font-headline);">Schedule Details</h3>
            <form action="${pageContext.request.contextPath}/support/book" method="post" style="display:flex;flex-direction:column;gap:1.25rem;">
                <input type="hidden" name="professionalId" value="${professional.id}"/>
                
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:1rem;">
                    <div>
                        <label class="form-label">Date</label>
                        <!-- HTML5 date picker restricts to future dates via min attribute (can be set via JS, for now just type date) -->
                        <input type="date" name="appointmentDate" class="form-input" required/>
                    </div>
                    <div>
                        <label class="form-label">Time Slot</label>
                        <select name="timeSlot" class="form-input" required>
                            <option value="">Select time...</option>
                            <option value="09:00 AM">09:00 AM - 10:00 AM</option>
                            <option value="10:30 AM">10:30 AM - 11:30 AM</option>
                            <option value="02:00 PM">02:00 PM - 03:00 PM</option>
                            <option value="03:30 PM">03:30 PM - 04:30 PM</option>
                        </select>
                    </div>
                </div>

                <div>
                    <label class="form-label">What would you like to discuss? (Optional, Confidential)</label>
                    <textarea name="notes" class="form-input" placeholder="Briefly describe what's on your mind..."></textarea>
                </div>

                <div style="display:flex;align-items:center;gap:0.5rem;padding:1rem;background:rgba(255,205,118,0.1);border-radius:var(--radius-md);margin-top:0.5rem;">
                    <span class="material-symbols-outlined" style="color:var(--tertiary);">info</span>
                    <p style="font-size:0.75rem;color:var(--on-surface-variant);margin:0;">Please note that this is not an emergency service. For immediate emergencies, please contact campus security or local emergency services.</p>
                </div>

                <button type="submit" class="btn btn-primary" style="margin-top:1rem;padding:1rem;">Confirm Booking</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

