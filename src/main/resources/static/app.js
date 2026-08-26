/**
 * Cooperative Gig Services Platform - Frontend Controller
 * Accessible, Human-Centric & Connected to Real Spring Boot + MySQL Backend
 */

// Dynamic API Base URL resolution
const BASE_ORIGIN = window.location.origin.includes(':') && !window.location.origin.includes('file://')
    ? window.location.origin
    : 'http://localhost:8080';

const API = {
    workers: `${BASE_ORIGIN}/api/workers`,
    customers: `${BASE_ORIGIN}/api/customers`,
    services: `${BASE_ORIGIN}/api/services`,
    serviceRequests: `${BASE_ORIGIN}/api/service-requests`
};

// Global state
let cachedServices = [];
let cachedCustomers = [];
let cachedWorkers = [];
let currentCustomer = null;
let currentServiceContext = null;
let activeSearchService = null;

// ==========================================================
// 1. INITIALIZATION & NAVIGATION
// ==========================================================
document.addEventListener('DOMContentLoaded', () => {
    initNavigation();
    checkCurrentCustomer();
    loadServices();
    fetchAllTablesData();
    setupWorkerFormValidation();
    setupCustomerFormValidation();
    setupCustomerLoginForm();
    setupBookingForm();

    // Default booking date to tomorrow
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    const dateInput = document.getElementById('bookDate');
    if (dateInput) {
        dateInput.value = tomorrow.toISOString().split('T')[0];
        dateInput.min = new Date().toISOString().split('T')[0];
    }
});


function initNavigation() {
    document.querySelectorAll('.main-nav .nav-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const tabId = btn.getAttribute('data-tab');
            switchNav(tabId, false);
            // Close mobile menu if open
            const nav = document.getElementById('mainNav');
            if (nav) nav.classList.remove('show-mobile');
        });
    });
}

function toggleMobileMenu() {
    const nav = document.getElementById('mainNav');
    if (nav) {
        nav.classList.toggle('show-mobile');
    }
}

function scrollToHowItWorks() {
    switchNav('home');
    setTimeout(() => {
        const block = document.getElementById('how-it-works-block');
        if (block) {
            block.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
    }, 100);
}

function switchNav(tabId, preserveContext = false) {
    document.querySelectorAll('.main-nav .nav-btn').forEach(b => {
        b.classList.toggle('active', b.getAttribute('data-tab') === tabId);
    });

    document.querySelectorAll('.page-section').forEach(sec => {
        sec.classList.remove('active');
    });

    const activeSection = document.getElementById(`section-${tabId}`);
    if (activeSection) {
        activeSection.classList.add('active');
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    // Direct navigation to worker registration without a service context unlocks the skill field
    if (tabId === 'worker-registration') {
        if (!preserveContext) {
            clearWorkerServiceContext();
        }
    } else if (tabId === 'services') {
        loadServices();
    } else if (tabId === 'admin') {
        fetchAllTablesData();
    }
}

function switchDbTab(tabContentId) {
    document.querySelectorAll('.db-tab-btn').forEach(btn => btn.classList.remove('active'));
    document.querySelectorAll('.db-tab-content').forEach(c => c.classList.remove('active'));

    const activeContent = document.getElementById(tabContentId);
    if (activeContent) activeContent.classList.add('active');

    const btns = document.querySelectorAll('.db-tab-btn');
    if (tabContentId === 'tab-workers' && btns[0]) btns[0].classList.add('active');
    if (tabContentId === 'tab-customers' && btns[1]) btns[1].classList.add('active');
    if (tabContentId === 'tab-requests' && btns[2]) btns[2].classList.add('active');
    if (tabContentId === 'tab-services' && btns[3]) btns[3].classList.add('active');
}


// ==========================================================
// 2. HERO SEARCH & QUICK SERVICE CHIPS
// ==========================================================
function executeHomeSearch() {
    const serviceVal = document.getElementById('homeServiceSelect').value.trim();
    const locationVal = document.getElementById('homeLocationInput').value.trim();

    if (!serviceVal) {
        alert('Please choose a service from the list (e.g. Plumbing, Electrician, Driver).');
        document.getElementById('homeServiceSelect').focus();
        return;
    }

    switchNav('services');
    findWorkersForService(serviceVal, null, locationVal);
}

function quickSearchService(serviceName) {
    switchNav('services');
    findWorkersForService(serviceName);
}


// ==========================================================
// 3. SERVICES MARKETPLACE (Dynamic MySQL Backend)
// ==========================================================
async function loadServices() {
    const servicesGrid = document.getElementById('servicesGrid');
    try {
        const response = await fetch(API.services);
        if (!response.ok) throw new Error(`HTTP ${response.status}`);
        
        const services = await response.json();
        cachedServices = services;
        renderServicesGrid(services);
        
        // Update stats
        const statService = document.getElementById('statServiceCount');
        if (statService) statService.textContent = services.length;
        const countTab = document.getElementById('countServicesTab');
        if (countTab) countTab.textContent = services.length;
    } catch (err) {
        console.error('Error loading services:', err);
        servicesGrid.innerHTML = `
            <div class="empty-state-box">
                <div class="empty-icon">⚠️</div>
                <h4>Could not load services</h4>
                <p>Please make sure the backend server is running and MySQL is active.</p>
                <button class="btn btn-primary btn-sm" onclick="loadServices()">Retry</button>
            </div>
        `;
    }
}

function renderServicesGrid(services) {
    const grid = document.getElementById('servicesGrid');
    if (!services || services.length === 0) {
        grid.innerHTML = `
            <div class="empty-state-box">
                <div class="empty-icon">🔍</div>
                <h4>No services found</h4>
                <p>No service categories are currently active in the database.</p>
            </div>
        `;
        return;
    }

    grid.innerHTML = services.map(s => {
        const btnText = getFriendlyButtonText(s.serviceName);
        return `
            <div class="service-card" data-name="${escapeHtml(s.serviceName).toLowerCase()}">
                <div class="service-card-top">
                    <div class="service-card-icon">${s.icon || '🛠️'}</div>
                    <h3>${escapeHtml(s.serviceName)}</h3>
                </div>
                <p class="service-card-desc">${escapeHtml(s.description)}</p>
                <button class="btn btn-primary service-card-btn" onclick="findWorkersForService('${escapeHtml(s.serviceName)}', ${s.serviceId})">
                    <span>${btnText}</span> &rarr;
                </button>
            </div>
        `;
    }).join('');
}

function getFriendlyButtonText(serviceName) {
    const name = (serviceName || '').toLowerCase();
    if (name.includes('plumb')) return 'Find Plumbers';
    if (name.includes('electric')) return 'Find Electricians';
    if (name.includes('ac') || name.includes('air')) return 'Find AC Technicians';
    if (name.includes('clean')) return 'Find Cleaners';
    if (name.includes('carpent')) return 'Find Carpenters';
    if (name.includes('paint')) return 'Find Painters';
    if (name.includes('driv')) return 'Find Drivers';
    if (name.includes('cook')) return 'Find Cooks';
    if (name.includes('mason') || name.includes('construct')) return 'Find Masons';
    if (name.includes('laund')) return 'Find Laundry Helpers';
    return `Find ${serviceName} Workers`;
}

function filterServiceCards() {
    const query = (document.getElementById('serviceSearchFilter').value || '').trim().toLowerCase();
    document.querySelectorAll('.service-card').forEach(card => {
        const name = card.getAttribute('data-name') || '';
        const desc = card.querySelector('.service-card-desc').textContent.toLowerCase();
        if (name.includes(query) || desc.includes(query)) {
            card.style.display = 'flex';
        } else {
            card.style.display = 'none';
        }
    });
}


// ==========================================================
// 4. WORKER DISCOVERY FLOW (Clean Human Cards)
// ==========================================================
async function findWorkersForService(serviceName, serviceId, locationFilter = '') {
    activeSearchService = { name: serviceName, id: serviceId };

    const searchContainer = document.getElementById('workerSearchResults');
    const badge = document.getElementById('searchServiceBadge');
    const title = document.getElementById('searchResultsTitle');
    const cardsGrid = document.getElementById('workerCardsGrid');
    const headerBtn = document.getElementById('headerRegisterServiceWorkerBtn');

    badge.textContent = serviceName;
    title.textContent = `Available Workers for ${serviceName}`;
    if (headerBtn) {
        headerBtn.textContent = `+ Join as ${serviceName} Worker`;
    }

    cardsGrid.innerHTML = `
        <div class="empty-state-box">
            <span class="btn-spinner"></span>
            <p>Finding available ${escapeHtml(serviceName)} workers near you...</p>
        </div>
    `;
    searchContainer.style.display = 'block';
    searchContainer.scrollIntoView({ behavior: 'smooth', block: 'start' });

    try {
        const url = `${API.workers}?skill=${encodeURIComponent(serviceName)}`;
        const response = await fetch(url);
        if (!response.ok) throw new Error(`HTTP ${response.status}`);
        
        let workers = await response.json();
        
        // Optional client-side location filter if passed from hero search
        if (locationFilter) {
            const locLower = locationFilter.toLowerCase();
            const filtered = workers.filter(w => (w.location || '').toLowerCase().includes(locLower));
            if (filtered.length > 0) {
                workers = filtered;
            }
        }

        renderMatchingWorkers(workers, serviceName, serviceId);
    } catch (err) {
        console.error('Error finding workers:', err);
        cardsGrid.innerHTML = `
            <div class="empty-state-box">
                <div class="empty-icon">⚠️</div>
                <h4>Could not retrieve workers</h4>
                <p>Please check your connection and try again.</p>
            </div>
        `;
    }
}

function registerForSelectedService() {
    if (activeSearchService && activeSearchService.name) {
        registerAsWorkerForService(activeSearchService.name);
    } else {
        switchNav('worker-registration');
    }
}

function registerAsWorkerForService(serviceName) {
    if (!serviceName) return;
    currentServiceContext = serviceName;

    // Pre-fill and lock skill input
    if (workerFields.skill) {
        workerFields.skill.value = serviceName;
        workerFields.skill.readOnly = true;
        workerFields.skill.classList.add('locked-input');
    }

    // Show context banner and lock badge
    const banner = document.getElementById('serviceContextBanner');
    const contextText = document.getElementById('serviceContextText');
    const lockBadge = document.getElementById('skillLockBadge');

    if (banner && contextText) {
        contextText.innerHTML = `Registering as: <strong>${escapeHtml(serviceName)}</strong>`;
        banner.style.display = 'flex';
    }
    if (lockBadge) lockBadge.style.display = 'inline-flex';

    if (workerFields.skill) workerFields.skill.classList.remove('invalid');
    if (workerErrorSpans.skill) workerErrorSpans.skill.textContent = '';

    // Switch to worker registration tab
    switchNav('worker-registration', true);

    setTimeout(() => {
        if (workerFields.fullName) workerFields.fullName.focus();
    }, 150);
}

function clearWorkerServiceContext() {
    currentServiceContext = null;

    if (workerFields.skill) {
        workerFields.skill.readOnly = false;
        workerFields.skill.classList.remove('locked-input');
        workerFields.skill.value = '';
    }

    const banner = document.getElementById('serviceContextBanner');
    const lockBadge = document.getElementById('skillLockBadge');

    if (banner) banner.style.display = 'none';
    if (lockBadge) lockBadge.style.display = 'none';

    if (workerFields.skill) workerFields.skill.focus();
}

function closeWorkerSearch() {
    document.getElementById('workerSearchResults').style.display = 'none';
}

function renderMatchingWorkers(workers, serviceName, serviceId) {
    const cardsGrid = document.getElementById('workerCardsGrid');
    
    if (!workers || workers.length === 0) {
        cardsGrid.innerHTML = `
            <div class="empty-state-box">
                <div class="empty-icon">👷‍♂️</div>
                <h4>No registered workers found for this service yet</h4>
                <p>Be the first skilled worker to offer <strong>${escapeHtml(serviceName)}</strong> services in your community!</p>
                <button class="btn btn-primary" onclick="registerAsWorkerForService('${escapeHtml(serviceName)}')">
                    + Register as a ${escapeHtml(serviceName)} Worker
                </button>
            </div>
        `;
        return;
    }

    cardsGrid.innerHTML = workers.map(w => {
        return `
            <div class="worker-match-card">
                <div class="worker-header">
                    <div class="worker-info-main">
                        <h4>${escapeHtml(w.fullName)}</h4>
                        <span class="worker-skill-badge">${escapeHtml(w.skill)}</span>
                    </div>
                    <span class="worker-badge-available">🟢 Available</span>
                </div>

                <div class="worker-details-list">
                    <div class="worker-detail-item">
                        <span>⭐</span>
                        <span><strong>${w.experienceYears}+ years experience</strong></span>
                    </div>
                    <div class="worker-detail-item">
                        <span>📍</span>
                        <span>Location: <strong>${escapeHtml(w.location)}</strong></span>
                    </div>
                    <div class="worker-detail-item">
                        <span>📱</span>
                        <span>Contact: <strong>${escapeHtml(w.phone)}</strong></span>
                    </div>
                </div>

                <button class="btn btn-primary" onclick="openBookingModal(${w.workerId}, '${escapeHtml(w.fullName)}', '${escapeHtml(w.skill)}', '${escapeHtml(w.location)}', ${serviceId}, '${escapeHtml(serviceName)}')">
                    <span>Request Service</span> &rarr;
                </button>
            </div>
        `;
    }).join('');
}


// ==========================================================
// 5. CUSTOMER REGISTRATION UX
// ==========================================================
const custForm = document.getElementById('customerForm');
const custSubmitBtn = document.getElementById('custSubmitBtn');
const custFields = {
    fullName: document.getElementById('custFullName'),
    phone: document.getElementById('custPhone'),
    email: document.getElementById('custEmail'),
    password: document.getElementById('custPassword'),
    confirmPassword: document.getElementById('custConfirmPassword'),
    location: document.getElementById('custLocation'),
    address: document.getElementById('custAddress')
};

const custErrorSpans = {
    fullName: document.getElementById('custFullNameError'),
    phone: document.getElementById('custPhoneError'),
    email: document.getElementById('custEmailError'),
    password: document.getElementById('custPasswordError'),
    confirmPassword: document.getElementById('custConfirmPasswordError'),
    location: document.getElementById('custLocationError'),
    address: document.getElementById('custAddressError')
};

function setupCustomerFormValidation() {
    if (!custForm) return;

    custFields.fullName.addEventListener('input', () => validateCustField('fullName'));
    custFields.phone.addEventListener('input', () => validateCustField('phone'));
    custFields.email.addEventListener('input', () => validateCustField('email'));
    custFields.password.addEventListener('input', () => validateCustField('password'));
    custFields.confirmPassword.addEventListener('input', () => validateCustField('confirmPassword'));
    custFields.location.addEventListener('input', () => validateCustField('location'));
    custFields.address.addEventListener('input', () => validateCustField('address'));

    custForm.addEventListener('submit', handleCustomerSignUp);
}

function validateCustField(fieldName) {
    const input = custFields[fieldName];
    const errorSpan = custErrorSpans[fieldName];
    const value = input.value.trim();
    let error = '';

    switch (fieldName) {
        case 'fullName':
            if (!value) error = 'Please enter your full name';
            else if (value.length < 2) error = 'Name must be at least 2 characters';
            break;
        case 'phone':
            const indianPhoneRegex = /^(?:\+91|91)?[6-9]\d{9}$/;
            if (!value) error = 'Please enter your mobile number';
            else if (!indianPhoneRegex.test(value.replace(/\s+/g, ''))) error = 'Please enter a valid 10-digit mobile number';
            break;
        case 'email':
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!value) error = 'Please enter your email address';
            else if (!emailRegex.test(value)) error = 'Please enter a valid email address';
            break;
        case 'password':
            if (!value) error = 'Please create a password';
            else if (value.length < 6) error = 'Password must be at least 6 characters long';
            break;
        case 'confirmPassword':
            if (!value) error = 'Please confirm your password';
            else if (value !== custFields.password.value) error = 'Passwords do not match';
            break;
        case 'location':
            if (!value) error = 'Please enter your city or area';
            break;
        case 'address':
            if (!value) error = 'Please enter your street address';
            break;
    }

    if (error) {
        input.classList.add('invalid');
        if (errorSpan) errorSpan.textContent = error;
        return false;
    } else {
        input.classList.remove('invalid');
        if (errorSpan) errorSpan.textContent = '';
        return true;
    }
}

function validateAllCustomerFields() {
    let isValid = true;
    Object.keys(custFields).forEach(f => {
        if (!validateCustField(f)) isValid = false;
    });
    return isValid;
}

async function handleCustomerSignUp(e) {
    e.preventDefault();
    hideAlert('customerErrorAlert');

    if (!validateAllCustomerFields()) {
        showCustomerError('Please complete all required fields correctly.');
        return;
    }

    const payload = {
        fullName: custFields.fullName.value.trim(),
        phone: custFields.phone.value.trim(),
        email: custFields.email.value.trim(),
        password: custFields.password.value,
        confirmPassword: custFields.confirmPassword.value,
        location: custFields.location.value.trim(),
        address: custFields.address.value.trim()
    };

    setCustomerSubmitting(true);

    try {
        const response = await fetch(API.customers, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });

        const data = await response.json();

        if (response.ok && data.success) {
            currentCustomer = data.data;
            updateUserUI();
            displayCustomerSuccess(data.data);
            fetchAllTablesData();
        } else {
            handleCustomerServerErrors(data);
        }
    } catch (err) {
        console.error('Customer signup error:', err);
        showCustomerError('We could not connect to the server. Please ensure the backend is running and try again.');
    } finally {
        setCustomerSubmitting(false);
    }
}

async function checkCurrentCustomer() {
    try {
        const response = await fetch(`${API.customers}/me`);
        if (response.ok) {
            const customer = await response.json();
            currentCustomer = customer;
        } else {
            currentCustomer = null;
        }
    } catch (err) {
        currentCustomer = null;
    }
    updateUserUI();
}

function updateUserUI() {
    const userStatus = document.getElementById('userHeaderStatus');
    const defaultActions = document.getElementById('headerDefaultActions');
    const userName = document.getElementById('headerUserName');

    if (currentCustomer) {
        if (userName) userName.textContent = currentCustomer.fullName;
        if (userStatus) userStatus.style.display = 'flex';
        if (defaultActions) defaultActions.style.display = 'none';
    } else {
        if (userStatus) userStatus.style.display = 'none';
        if (defaultActions) defaultActions.style.display = 'flex';
    }
}

function setupCustomerLoginForm() {
    const loginForm = document.getElementById('customerLoginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', handleCustomerLogin);
    }
}

async function handleCustomerLogin(e) {
    e.preventDefault();
    hideAlert('customerLoginErrorAlert');

    const emailInput = document.getElementById('loginEmail');
    const passwordInput = document.getElementById('loginPassword');
    const submitBtn = document.getElementById('loginSubmitBtn');

    const email = emailInput ? emailInput.value.trim() : '';
    const password = passwordInput ? passwordInput.value : '';

    if (!email || !password) {
        showCustomerLoginError('Please enter both your email address and password.');
        return;
    }

    const btnText = submitBtn.querySelector('.btn-text');
    const btnSpinner = submitBtn.querySelector('.btn-spinner');
    submitBtn.disabled = true;
    if (btnText) btnText.textContent = 'Logging in...';
    if (btnSpinner) btnSpinner.style.display = 'inline-block';

    try {
        const response = await fetch(`${API.customers}/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
        });

        let data = {};
        try {
            data = await response.json();
        } catch (e) {
            data = {};
        }

        if (response.ok && data.success) {
            currentCustomer = data.data;
            updateUserUI();
            if (loginForm) loginForm.reset();
            switchNav('services');
        } else {
            showCustomerLoginError(data.message || 'Invalid email or password.');
        }
    } catch (err) {
        console.error('Login error:', err);
        showCustomerLoginError('Could not connect to the server. Please ensure the backend is running.');
    } finally {

        submitBtn.disabled = false;
        if (btnText) btnText.textContent = 'Login';
        if (btnSpinner) btnSpinner.style.display = 'none';
    }
}

function showCustomerLoginError(msg) {
    const el = document.getElementById('customerLoginErrorMessage');
    if (el) el.textContent = msg;
    const alertBox = document.getElementById('customerLoginErrorAlert');
    if (alertBox) {
        alertBox.style.display = 'flex';
        alertBox.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
}

async function handleCustomerLogout() {
    try {
        await fetch(`${API.customers}/logout`, { method: 'POST' });
    } catch (err) {
        console.error('Logout error:', err);
    }
    currentCustomer = null;
    updateUserUI();
    switchNav('home');
}


function setCustomerSubmitting(isSubmitting) {
    const btnText = custSubmitBtn.querySelector('.btn-text');
    const btnSpinner = custSubmitBtn.querySelector('.btn-spinner');

    if (isSubmitting) {
        custSubmitBtn.disabled = true;
        btnText.textContent = 'Creating your account...';
        btnSpinner.style.display = 'inline-block';
    } else {
        custSubmitBtn.disabled = false;
        btnText.textContent = 'Create Customer Account';
        btnSpinner.style.display = 'none';
    }
}

function displayCustomerSuccess(customer) {
    document.getElementById('resCustName').textContent = customer.fullName;
    document.getElementById('resCustPhone').textContent = customer.phone;
    document.getElementById('resCustEmail').textContent = customer.email;
    document.getElementById('resCustLocation').textContent = customer.location;
    document.getElementById('resCustAddress').textContent = customer.address;

    custForm.style.display = 'none';
    const card = document.getElementById('customerSuccessCard');
    card.style.display = 'block';
    card.scrollIntoView({ behavior: 'smooth', block: 'start' });
}

function resetCustomerForm() {
    custForm.reset();
    Object.keys(custFields).forEach(k => custFields[k].classList.remove('invalid'));
    Object.keys(custErrorSpans).forEach(k => custErrorSpans[k].textContent = '');
    document.getElementById('customerSuccessCard').style.display = 'none';
    custForm.style.display = 'block';
    custFields.fullName.focus();
}

function proceedToBookServiceWithCurrentCustomer() {
    switchNav('services');
}

function handleCustomerServerErrors(data) {
    const errorList = document.getElementById('customerErrorList');
    errorList.innerHTML = '';
    let msg = data.message || 'We could not complete your registration.';

    if (data.errors && typeof data.errors === 'object') {
        Object.entries(data.errors).forEach(([field, errMsg]) => {
            const li = document.createElement('li');
            li.textContent = errMsg;
            errorList.appendChild(li);

            if (custFields[field]) custFields[field].classList.add('invalid');
            if (custErrorSpans[field]) custErrorSpans[field].textContent = errMsg;
        });
    }

    showCustomerError(msg);
}

function showCustomerError(msg) {
    const el = document.getElementById('customerErrorMessage');
    if (el) el.textContent = msg;
    const alertBox = document.getElementById('customerErrorAlert');
    if (alertBox) {
        alertBox.style.display = 'flex';
        alertBox.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
}


// ==========================================================
// 6. WORKER REGISTRATION UX ("Become a Worker")
// ==========================================================
const workerForm = document.getElementById('workerForm');
const submitBtn = document.getElementById('submitBtn');
const workerFields = {
    fullName: document.getElementById('fullName'),
    phone: document.getElementById('phone'),
    email: document.getElementById('email'),
    skill: document.getElementById('skill'),
    experienceYears: document.getElementById('experienceYears'),
    location: document.getElementById('location'),
    invitedBy: document.getElementById('invitedBy')
};

const workerErrorSpans = {
    fullName: document.getElementById('fullNameError'),
    phone: document.getElementById('phoneError'),
    email: document.getElementById('emailError'),
    skill: document.getElementById('skillError'),
    experienceYears: document.getElementById('experienceYearsError'),
    location: document.getElementById('locationError'),
    invitedBy: document.getElementById('invitedByError')
};

function setupWorkerFormValidation() {
    if (!workerForm) return;

    workerFields.fullName.addEventListener('input', () => validateWorkerField('fullName'));
    workerFields.phone.addEventListener('input', () => validateWorkerField('phone'));
    workerFields.email.addEventListener('input', () => validateWorkerField('email'));
    workerFields.skill.addEventListener('input', () => validateWorkerField('skill'));
    workerFields.location.addEventListener('input', () => validateWorkerField('location'));

    workerForm.addEventListener('submit', handleWorkerRegistration);
}

function syncExperienceInput() {
    const select = document.getElementById('experienceSelect');
    const hiddenInput = document.getElementById('experienceYears');
    if (select && hiddenInput) {
        hiddenInput.value = select.value;
    }
}

function validateWorkerField(fieldName) {
    const input = workerFields[fieldName];
    const errorSpan = workerErrorSpans[fieldName];
    const value = input.value.trim();
    let error = '';

    switch (fieldName) {
        case 'fullName':
            if (!value) error = 'Please enter your full name';
            else if (value.length < 2) error = 'Name must be at least 2 characters';
            break;
        case 'phone':
            const phoneRegex = /^[0-9+\-\s]{7,20}$/;
            if (!value) error = 'Please enter your mobile number';
            else if (!phoneRegex.test(value)) error = 'Please enter a valid mobile number';
            break;
        case 'email':
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!value) error = 'Please enter your email address';
            else if (!emailRegex.test(value)) error = 'Please enter a valid email address';
            break;
        case 'skill':
            if (!value) error = 'Please choose or enter your service skill';
            break;
        case 'location':
            if (!value) error = 'Please enter your city or area';
            break;
    }

    if (error) {
        input.classList.add('invalid');
        if (errorSpan) errorSpan.textContent = error;
        return false;
    } else {
        input.classList.remove('invalid');
        if (errorSpan) errorSpan.textContent = '';
        return true;
    }
}

function validateAllWorkerFields() {
    let isValid = true;
    const req = ['fullName', 'phone', 'email', 'skill', 'location'];
    req.forEach(f => {
        if (!validateWorkerField(f)) isValid = false;
    });
    return isValid;
}

async function handleWorkerRegistration(e) {
    e.preventDefault();
    hideAlert('errorAlert');

    if (!validateAllWorkerFields()) {
        showWorkerError('Please complete all required fields correctly.');
        return;
    }

    syncExperienceInput();

    const payload = {
        fullName: workerFields.fullName.value.trim(),
        phone: workerFields.phone.value.trim(),
        email: workerFields.email.value.trim(),
        skill: workerFields.skill.value.trim(),
        experienceYears: parseInt(workerFields.experienceYears.value || 3, 10),
        location: workerFields.location.value.trim(),
        invitedBy: workerFields.invitedBy.value.trim() || 'Self'
    };

    setWorkerSubmitting(true);

    try {
        const response = await fetch(API.workers, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });

        const data = await response.json();

        if (response.ok && data.success) {
            displayWorkerSuccess(data.data);
            fetchAllTablesData();
        } else {
            handleWorkerServerErrors(data);
        }
    } catch (err) {
        console.error('Worker registration error:', err);
        showWorkerError('We could not complete your registration. Please check your connection and try again.');
    } finally {
        setWorkerSubmitting(false);
    }
}

function setWorkerSubmitting(isSubmitting) {
    const btnText = submitBtn.querySelector('.btn-text');
    const btnSpinner = submitBtn.querySelector('.btn-spinner');

    if (isSubmitting) {
        submitBtn.disabled = true;
        btnText.textContent = 'Registering worker...';
        btnSpinner.style.display = 'inline-block';
    } else {
        submitBtn.disabled = false;
        btnText.textContent = 'Register as a Worker';
        btnSpinner.style.display = 'none';
    }
}

function displayWorkerSuccess(worker) {
    document.getElementById('resFullName').textContent = worker.fullName;
    document.getElementById('resPhone').textContent = worker.phone;
    document.getElementById('resEmail').textContent = worker.email;
    document.getElementById('resSkill').textContent = worker.skill;
    document.getElementById('resExperience').textContent = `${worker.experienceYears} Years`;
    document.getElementById('resLocation').textContent = worker.location;

    const viewBtn = document.getElementById('viewInServicesBtn');
    if (viewBtn) {
        viewBtn.onclick = () => viewWorkerInServiceSearch(worker.skill);
        viewBtn.textContent = `🔍 View in ${worker.skill} Services →`;
    }

    workerForm.style.display = 'none';
    const card = document.getElementById('successCard');
    card.style.display = 'block';
    card.scrollIntoView({ behavior: 'smooth', block: 'start' });
}

function viewWorkerInServiceSearch(skill) {
    switchNav('services');
    findWorkersForService(skill);
}

function resetAndShowForm() {
    workerForm.reset();
    Object.keys(workerFields).forEach(k => {
        if (workerFields[k]) workerFields[k].classList.remove('invalid');
    });
    Object.keys(workerErrorSpans).forEach(k => {
        if (workerErrorSpans[k]) workerErrorSpans[k].textContent = '';
    });
    document.getElementById('successCard').style.display = 'none';
    workerForm.style.display = 'block';

    if (currentServiceContext) {
        registerAsWorkerForService(currentServiceContext);
    } else {
        clearWorkerServiceContext();
        workerFields.fullName.focus();
    }
}

function handleWorkerServerErrors(data) {
    const errorList = document.getElementById('errorList');
    errorList.innerHTML = '';
    let msg = data.message || 'We could not complete your worker registration.';

    if (data.errors && typeof data.errors === 'object') {
        Object.entries(data.errors).forEach(([field, errMsg]) => {
            const li = document.createElement('li');
            li.textContent = errMsg;
            errorList.appendChild(li);

            if (workerFields[field]) workerFields[field].classList.add('invalid');
            if (workerErrorSpans[field]) workerErrorSpans[field].textContent = errMsg;
        });
    }

    showWorkerError(msg);
}

function showWorkerError(msg) {
    const el = document.getElementById('errorMessage');
    if (el) el.textContent = msg;
    const alertBox = document.getElementById('errorAlert');
    if (alertBox) {
        alertBox.style.display = 'flex';
        alertBox.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
}


// ==========================================================
// 7. SERVICE BOOKING / REQUEST MODAL
// ==========================================================
function setupBookingForm() {
    const bookingForm = document.getElementById('bookingForm');
    if (bookingForm) {
        bookingForm.addEventListener('submit', handleServiceBookingSubmit);
    }
}

function openBookingModal(workerId, workerName, workerSkill, workerLocation, serviceId, serviceName) {
    if (!currentCustomer) {
        checkCurrentCustomer().then(() => {
            if (!currentCustomer) {
                alert('Please log in or create an account to request a service.');
                switchNav('customer-login');
                return;
            }
            openBookingModal(workerId, workerName, workerSkill, workerLocation, serviceId, serviceName);
        });
        return;
    }

    document.getElementById('bookWorkerId').value = workerId;
    document.getElementById('bookServiceId').value = serviceId || (cachedServices[0] ? cachedServices[0].serviceId : 1);
    
    document.getElementById('bookWorkerName').textContent = workerName;
    document.getElementById('bookWorkerSkillLocation').textContent = `${workerSkill} • ${workerLocation}`;

    // Display current customer's account info
    const custNameEl = document.getElementById('bookCustomerName');
    const custDetailsEl = document.getElementById('bookCustomerDetails');
    if (custNameEl) custNameEl.textContent = currentCustomer.fullName;
    if (custDetailsEl) custDetailsEl.textContent = `${currentCustomer.phone} • ${currentCustomer.location}`;

    document.getElementById('bookingForm').style.display = 'block';
    document.getElementById('bookingSuccessBox').style.display = 'none';

    if (currentCustomer.address) {
        document.getElementById('bookLocation').value = currentCustomer.address;
    } else if (currentCustomer.location) {
        document.getElementById('bookLocation').value = currentCustomer.location;
    }

    document.getElementById('bookingModal').style.display = 'flex';
}

function closeBookingModal() {
    document.getElementById('bookingModal').style.display = 'none';
}

async function handleServiceBookingSubmit(e) {
    e.preventDefault();

    if (!currentCustomer) {
        alert('Please log in to your customer account before requesting a service.');
        closeBookingModal();
        switchNav('customer-login');
        return;
    }

    const workerIdVal = document.getElementById('bookWorkerId').value;
    const serviceIdVal = document.getElementById('bookServiceId').value;
    const locationVal = document.getElementById('bookLocation').value.trim();
    const dateVal = document.getElementById('bookDate').value;
    const timeVal = document.getElementById('bookTime').value;
    const descVal = document.getElementById('bookDescription').value.trim();

    if (!locationVal || !dateVal || !descVal) {
        alert('Please complete all required fields for the service request.');
        return;
    }

    const payload = {
        workerId: parseInt(workerIdVal, 10),
        serviceId: parseInt(serviceIdVal, 10),
        description: descVal,
        location: locationVal,
        preferredDate: dateVal,
        preferredTime: timeVal
    };

    const submitBtn = document.getElementById('bookSubmitBtn');
    submitBtn.disabled = true;
    submitBtn.querySelector('.btn-text').textContent = 'Submitting request...';
    submitBtn.querySelector('.btn-spinner').style.display = 'inline-block';

    try {
        const response = await fetch(API.serviceRequests, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });

        const data = await response.json();

        if (response.ok && data.success) {
            displayBookingSuccess(data.data);
            fetchAllTablesData();
        } else if (response.status === 401) {
            alert('Your session has expired. Please log in again.');
            currentCustomer = null;
            updateUserUI();
            closeBookingModal();
            switchNav('customer-login');
        } else {
            alert('Could not book service: ' + (data.message || 'Validation error'));
        }
    } catch (err) {
        console.error('Booking error:', err);
        alert('Could not submit service request. Please check server connection.');
    } finally {
        submitBtn.disabled = false;
        submitBtn.querySelector('.btn-text').textContent = 'Confirm Service Request';
        submitBtn.querySelector('.btn-spinner').style.display = 'none';
    }
}

function displayBookingSuccess(req) {
    document.getElementById('resReqWorker').textContent = `${req.workerName} (${req.workerSkill})`;
    document.getElementById('resReqCustomer').textContent = `${req.customerName} (${req.customerPhone})`;
    document.getElementById('resReqService').textContent = req.serviceName || 'Home Service';
    document.getElementById('resReqDateTime').textContent = `${req.preferredDate} @ ${req.preferredTime}`;

    document.getElementById('bookingForm').style.display = 'none';
    document.getElementById('bookingSuccessBox').style.display = 'block';
}


// ==========================================================
// 8. ADMIN / LIVE MYSQL DATABASE INSPECTOR
// ==========================================================
async function fetchAllTablesData() {
    fetchWorkersTable();
    fetchCustomersTable();
    fetchRequestsTable();
}

async function fetchWorkersTable() {
    const tbody = document.getElementById('dbWorkersTableBody');
    try {
        const response = await fetch(API.workers);
        if (!response.ok) throw new Error(`HTTP ${response.status}`);
        const workers = await response.json();
        cachedWorkers = workers;

        document.getElementById('countWorkersTab').textContent = workers.length;
        const statWorker = document.getElementById('statWorkerCount');
        if (statWorker) statWorker.textContent = workers.length;

        if (workers.length === 0) {
            tbody.innerHTML = '<tr><td colspan="9" class="text-center text-muted">No workers in database yet.</td></tr>';
            return;
        }

        tbody.innerHTML = workers.map(w => `
            <tr>
                <td><strong>#${w.workerId}</strong></td>
                <td>${escapeHtml(w.fullName)}</td>
                <td>${escapeHtml(w.phone)}</td>
                <td>${escapeHtml(w.email)}</td>
                <td><span class="highlight-id">${escapeHtml(w.skill)}</span></td>
                <td>${w.experienceYears} Yrs</td>
                <td>${escapeHtml(w.location)}</td>
                <td>${escapeHtml(w.invitedBy || 'Self')}</td>
                <td>${formatDateTime(w.createdAt)}</td>
            </tr>
        `).join('');
    } catch (err) {
        tbody.innerHTML = '<tr><td colspan="9" class="text-center text-muted">Cannot connect to MySQL workers table.</td></tr>';
    }
}

async function fetchCustomersTable() {
    const tbody = document.getElementById('dbCustomersTableBody');
    try {
        const response = await fetch(API.customers);
        if (!response.ok) throw new Error(`HTTP ${response.status}`);
        const customers = await response.json();
        cachedCustomers = customers;

        document.getElementById('countCustomersTab').textContent = customers.length;
        const statCustomer = document.getElementById('statCustomerCount');
        if (statCustomer) statCustomer.textContent = customers.length;

        if (customers.length === 0) {
            tbody.innerHTML = '<tr><td colspan="7" class="text-center text-muted">No customers in database yet.</td></tr>';
            return;
        }

        tbody.innerHTML = customers.map(c => `
            <tr>
                <td><strong>#${c.customerId}</strong></td>
                <td>${escapeHtml(c.fullName)}</td>
                <td>${escapeHtml(c.phone)}</td>
                <td>${escapeHtml(c.email)}</td>
                <td>${escapeHtml(c.location)}</td>
                <td>${escapeHtml(c.address)}</td>
                <td>${formatDateTime(c.createdAt)}</td>
            </tr>
        `).join('');
    } catch (err) {
        tbody.innerHTML = '<tr><td colspan="7" class="text-center text-muted">Cannot connect to MySQL customers table.</td></tr>';
    }
}

async function fetchRequestsTable() {
    const tbody = document.getElementById('dbRequestsTableBody');
    try {
        const response = await fetch(API.serviceRequests);
        if (!response.ok) throw new Error(`HTTP ${response.status}`);
        const requests = await response.json();

        document.getElementById('countRequestsTab').textContent = requests.length;
        const statReq = document.getElementById('statRequestCount');
        if (statReq) statReq.textContent = requests.length;

        if (requests.length === 0) {
            tbody.innerHTML = '<tr><td colspan="9" class="text-center text-muted">No service requests yet.</td></tr>';
            return;
        }

        tbody.innerHTML = requests.map(r => `
            <tr>
                <td><strong>#${r.requestId}</strong></td>
                <td>${escapeHtml(r.customerName || '')}</td>
                <td>${escapeHtml(r.workerName || '')} (${escapeHtml(r.workerSkill || '')})</td>
                <td>${escapeHtml(r.serviceName || '')}</td>
                <td>${escapeHtml(r.description || '')}</td>
                <td>${escapeHtml(r.location || '')}</td>
                <td>${escapeHtml(r.preferredDate)} (${escapeHtml(r.preferredTime)})</td>
                <td><span class="badge-pending">${escapeHtml(r.status || 'PENDING')}</span></td>
                <td>${formatDateTime(r.createdAt)}</td>
            </tr>
        `).join('');
    } catch (err) {
        tbody.innerHTML = '<tr><td colspan="9" class="text-center text-muted">Cannot connect to MySQL service_requests table.</td></tr>';
    }
}


// ==========================================================
// 9. UTILITY HELPERS
// ==========================================================
function hideAlert(id) {
    const el = document.getElementById(id);
    if (el) el.style.display = 'none';
}

function formatDateTime(isoString) {
    if (!isoString) return new Date().toLocaleString();
    const date = new Date(isoString);
    return isNaN(date.getTime()) ? isoString : date.toLocaleString();
}

function escapeHtml(str) {
    if (!str) return '';
    return String(str).replace(/[&<>"']/g, function (m) {
        return ({
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        })[m];
    });
}
