/**
 * MindHub — Common JavaScript Utilities
 */

// Show/hide mobile sidebar
function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    if (sidebar) {
        sidebar.classList.toggle('show-mobile');
    }
}

// Auto-dismiss alerts after 5 seconds
document.addEventListener('DOMContentLoaded', function() {
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(function(alert) {
        setTimeout(function() {
            alert.style.transition = 'opacity 0.5s';
            alert.style.opacity = '0';
            setTimeout(function() { alert.remove(); }, 500);
        }, 5000);
    });
});

// Confirm delete actions
function confirmDelete(form, itemName) {
    if (confirm('Are you sure you want to delete this ' + (itemName || 'item') + '?')) {
        form.submit();
    }
    return false;
}
