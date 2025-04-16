// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', function () {
    initializeNavigation();
    initializeFormValidation();
    initializeDataTables();
    initializeAlerts();
    initializeFilters();
});

// Navigation active state
function initializeNavigation() {
    const currentPath = window.location.pathname;
    document.querySelectorAll('.navbar-nav .nav-link').forEach(link => {
        if (currentPath.includes(link.getAttribute('href'))) {
            link.classList.add('active');
            link.setAttribute('aria-current', 'page');
        }
    });
}

// Form validation
function initializeFormValidation() {
    const forms = document.querySelectorAll('.needs-validation');
    forms.forEach(form => {
        form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        });

        // Real-time validation
        form.querySelectorAll('input').forEach(input => {
            input.addEventListener('change', () => {
                validateField(input);
            });
        });
    });
}

// Field validation
function validateField(field) {
    if (field.type === 'datetime-local') {
        validateDateTime(field);
    } else if (field.classList.contains('price-input')) {
        validatePrice(field);
    } else if (field.classList.contains('percentage-input')) {
        validatePercentage(field);
    }
}

// DateTime validation
function validateDateTime(field) {
    const selectedDate = new Date(field.value);
    const now = new Date();

    if (selectedDate < now) {
        field.setCustomValidity('La date doit être ultérieure à maintenant');
    } else {
        field.setCustomValidity('');
    }
}

// Price validation
function validatePrice(field) {
    const value = parseFloat(field.value);
    if (isNaN(value) || value <= 0) {
        field.setCustomValidity('Le prix doit être supérieur à 0');
    } else {
        field.setCustomValidity('');
    }
}

// Percentage validation
function validatePercentage(field) {
    const value = parseFloat(field.value);
    if (isNaN(value) || value < 0 || value > 100) {
        field.setCustomValidity('Le pourcentage doit être entre 0 et 100');
    } else {
        field.setCustomValidity('');
    }
}

// Initialize DataTables
function initializeDataTables() {
    const tables = document.querySelectorAll('.datatable');
    tables.forEach(table => {
        new DataTable(table, {
            language: {
                url: '//cdn.datatables.net/plug-ins/1.13.4/i18n/fr-FR.json'
            },
            pageLength: 10,
            responsive: true
        });
    });
}

// Alert management
function initializeAlerts() {
    document.querySelectorAll('.alert').forEach(alert => {
        setTimeout(() => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }, 5000);
    });
}

// Filter management
function initializeFilters() {
    const filterForms = document.querySelectorAll('.filter-form');
    filterForms.forEach(form => {
        const toggleBtn = form.querySelector('.toggle-filters');
        const filterContent = form.querySelector('.filter-content');

        if (toggleBtn && filterContent) {
            toggleBtn.addEventListener('click', () => {
                filterContent.classList.toggle('show');
                const isExpanded = filterContent.classList.contains('show');
                toggleBtn.setAttribute('aria-expanded', isExpanded);
            });
        }
    });
}

// Format currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('fr-MG', {
        style: 'currency',
        currency: 'MGA'
    }).format(amount);
}

// Format date
function formatDate(date) {
    return new Intl.DateTimeFormat('fr-FR', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit'
    }).format(new Date(date));
}

// Confirmation dialogs
function confirmDelete(message) {
    return confirm(message || 'Êtes-vous sûr de vouloir supprimer cet élément ?');
}

// Reset form
function resetForm(formId) {
    const form = document.getElementById(formId);
    if (form) {
        form.reset();
        form.classList.remove('was-validated');
        if (form.querySelector('.filter-content')) {
            form.submit();
        }
    }
}