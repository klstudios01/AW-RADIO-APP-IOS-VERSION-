// AW Radio - Complete Functional Web Admin Portal JavaScript Logic

// 1. Data Store
const mockStations = [
    { id: '1', name: "AW Radio Main Stream", category: "Gospel", frequency: "104.5 FM", listeners: 4820, streamUrl: "https://stream.zeno.fm/f3wvbbqmdg8uv", isLive: true },
    { id: '2', name: "AW News & Talk 24/7", category: "News", frequency: "98.1 FM", listeners: 3120, streamUrl: "https://stream.zeno.fm/f3wvbbqmdg8uv", isLive: true },
    { id: '3', name: "AW Praise & Worship", category: "Gospel", frequency: "107.9 FM", listeners: 6540, streamUrl: "https://stream.zeno.fm/f3wvbbqmdg8uv", isLive: true },
    { id: '4', name: "AW Sports Arena", category: "Sports", frequency: "92.3 FM", listeners: 2190, streamUrl: "https://stream.zeno.fm/f3wvbbqmdg8uv", isLive: true }
];

const mockSchedules = [
    { title: "Morning Glory Drive", station: "AW Radio Main Stream", presenter: "Pastor David Miller", timeSlot: "06:00 AM - 10:00 AM", category: "Gospel" },
    { title: "Midday Community Forum", station: "AW News & Talk 24/7", presenter: "Sarah Jenkins", timeSlot: "10:00 AM - 02:00 PM", category: "Talk Shows" },
    { title: "Evening Worship & Healing", station: "AW Praise & Worship", presenter: "Michael Evans", timeSlot: "06:00 PM - 10:00 PM", category: "Gospel" }
];

const mockNews = [
    { title: "AW Radio Expands Live Streaming to Apple Dynamic Island & CarPlay", category: "Technology", author: "AW Media Desk", date: "2026-08-07", readTime: "4 mins" },
    { title: "Annual Gospel Music Festival 2026 Announced for October", category: "Entertainment", author: "Events Team", date: "2026-08-06", readTime: "3 mins" },
    { title: "Global Community Spotlight: Youth Empowerment & Education Hour", category: "Education", author: "Community Editor", date: "2026-08-05", readTime: "5 mins" }
];

const mockNotifications = [
    { title: "Live Broadcast Starting Now!", message: "Morning Glory Drive with Pastor David is live on AW Main Stream.", target: "All iOS Listeners", date: "2026-08-07 06:00 AM", status: "SENT" },
    { title: "Breaking News Alert", message: "AW Radio launches native Dynamic Island integration.", target: "All iOS Listeners", date: "2026-08-06 10:30 AM", status: "SENT" }
];

const mockUsers = [
    { name: "Pastor David Miller", email: "david.m@awradio.com", role: "Presenter", listeningMins: 340, joinedDate: "2026-01-15" },
    { name: "Sarah Jenkins", email: "sarah.j@awradio.com", role: "Presenter", listeningMins: 210, joinedDate: "2026-02-01" },
    { name: "Listener John Doe", email: "john.doe@gmail.com", role: "User", listeningMins: 142, joinedDate: "2026-05-20" },
    { name: "Admin Director", email: "admin@awradio.com", role: "Admin", listeningMins: 890, joinedDate: "2026-01-01" }
];

// 2. Tab Navigation Functionality
function switchTab(tabId) {
    document.querySelectorAll('.tab-content').forEach(tab => tab.classList.remove('active'));
    document.querySelectorAll('.nav-btn').forEach(btn => btn.classList.remove('active'));
    
    const targetTab = document.getElementById(`tab-${tabId}`);
    const targetBtn = document.getElementById(`btn-${tabId}`);
    
    if (targetTab) targetTab.classList.add('active');
    if (targetBtn) targetBtn.classList.add('active');
    
    const pageTitleMap = {
        'dashboard': 'Dashboard & Listener Analytics',
        'stations': 'Radio Streams Management',
        'schedules': 'Broadcast Programs & Schedules',
        'news': 'Published News & Articles',
        'notifications': 'Push Notifications Center',
        'users': 'User Accounts & Roles'
    };
    
    const titleEl = document.getElementById('page-title');
    if (titleEl && pageTitleMap[tabId]) {
        titleEl.textContent = pageTitleMap[tabId];
    }
}

// 3. Modal Handlers
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) modal.classList.add('active');
}

function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) modal.classList.remove('active');
}

// 4. Render Table Functions
function renderStationsTable() {
    const tbody = document.getElementById('stations-table-body');
    if (!tbody) return;
    tbody.innerHTML = mockStations.map((s, idx) => `
        <tr>
            <td><strong>${s.name}</strong></td>
            <td><span style="color:#f97316;font-weight:600;">${s.category}</span></td>
            <td>${s.frequency}</td>
            <td>${s.listeners.toLocaleString()} listeners</td>
            <td style="font-family:monospace;font-size:12px;">${s.streamUrl}</td>
            <td>
                <span class="badge live" style="${s.isLive ? '' : 'background:rgba(255,255,255,0.1);color:#94a3b8;border-color:#94a3b8;'}">
                    ${s.isLive ? 'ONLINE' : 'OFFLINE'}
                </span>
            </td>
            <td>
                <button class="btn btn-secondary" style="padding:4px 10px;font-size:12px;" onclick="toggleStationStatus(${idx})">Toggle Status</button>
            </td>
        </tr>
    `).join('');
    
    const countEl = document.getElementById('total-stations-count');
    if (countEl) countEl.textContent = `${mockStations.length} Stations`;
}

function toggleStationStatus(idx) {
    if (mockStations[idx]) {
        mockStations[idx].isLive = !mockStations[idx].isLive;
        renderStationsTable();
    }
}

function renderSchedulesTable() {
    const tbody = document.getElementById('schedules-table-body');
    if (!tbody) return;
    tbody.innerHTML = mockSchedules.map(sch => `
        <tr>
            <td><strong>${sch.title}</strong></td>
            <td>${sch.station}</td>
            <td>${sch.presenter}</td>
            <td><span style="color:#f97316;font-weight:600;">${sch.timeSlot}</span></td>
            <td>${sch.category}</td>
            <td><button class="btn btn-secondary" style="padding:4px 10px;font-size:12px;">Edit</button></td>
        </tr>
    `).join('');
}

function renderNewsTable() {
    const tbody = document.getElementById('news-table-body');
    if (!tbody) return;
    tbody.innerHTML = mockNews.map(n => `
        <tr>
            <td><strong>${n.title}</strong></td>
            <td><span style="color:#2563eb;font-weight:600;">${n.category}</span></td>
            <td>${n.author}</td>
            <td>${n.date}</td>
            <td>${n.readTime}</td>
            <td><button class="btn btn-secondary" style="padding:4px 10px;font-size:12px;">Manage</button></td>
        </tr>
    `).join('');
    
    const countEl = document.getElementById('total-news-count');
    if (countEl) countEl.textContent = `${mockNews.length} Articles`;
}

function renderNotificationsTable() {
    const tbody = document.getElementById('notifications-table-body');
    if (!tbody) return;
    tbody.innerHTML = mockNotifications.map(notif => `
        <tr>
            <td><strong>${notif.title}</strong></td>
            <td>${notif.message}</td>
            <td><span style="color:#f97316;">${notif.target}</span></td>
            <td>${notif.date}</td>
            <td><span class="badge live" style="background:rgba(34,197,94,0.2);color:#22c55e;border-color:#22c55e;">${notif.status}</span></td>
        </tr>
    `).join('');
}

function renderUsersTable() {
    const tbody = document.getElementById('users-table-body');
    if (!tbody) return;
    tbody.innerHTML = mockUsers.map(user => `
        <tr>
            <td><strong>${user.name}</strong></td>
            <td>${user.email}</td>
            <td>
                <span style="padding:2px 8px;border-radius:10px;font-size:11px;font-weight:700;${user.role === 'Admin' ? 'background:rgba(249,115,22,0.2);color:#f97316;' : user.role === 'Presenter' ? 'background:rgba(37,99,235,0.2);color:#2563eb;' : 'background:rgba(255,255,255,0.1);color:#fff;'}">
                    ${user.role}
                </span>
            </td>
            <td>${user.listeningMins} mins</td>
            <td>${user.joinedDate}</td>
            <td><button class="btn btn-secondary" style="padding:4px 10px;font-size:12px;">Manage</button></td>
        </tr>
    `).join('');
}

// 5. Chart Initialization
function initChart() {
    const ctx = document.getElementById('listenersChart');
    if (!ctx) return;
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['00:00', '04:00', '08:00', '12:00', '16:00', '20:00', '24:00'],
            datasets: [{
                label: 'Active Listeners Today',
                data: [4200, 3100, 11500, 14200, 16670, 15400, 9800],
                borderColor: '#f97316',
                backgroundColor: 'rgba(249, 115, 22, 0.15)',
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { labels: { color: '#ffffff' } }
            },
            scales: {
                x: { ticks: { color: '#94a3b8' }, grid: { color: 'rgba(255,255,255,0.05)' } },
                y: { ticks: { color: '#94a3b8' }, grid: { color: 'rgba(255,255,255,0.05)' } }
            }
        }
    });
}

// 6. Form Submission Handlers
document.addEventListener('DOMContentLoaded', () => {
    renderStationsTable();
    renderSchedulesTable();
    renderNewsTable();
    renderNotificationsTable();
    renderUsersTable();
    initChart();

    // Station Form Submit
    const stationForm = document.getElementById('station-form');
    if (stationForm) {
        stationForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const name = document.getElementById('station-name').value;
            const category = document.getElementById('station-category').value;
            const frequency = document.getElementById('station-freq').value;
            const streamUrl = document.getElementById('station-url').value;
            
            mockStations.unshift({
                id: String(mockStations.length + 1),
                name,
                category,
                frequency,
                listeners: 0,
                streamUrl,
                isLive: true
            });
            
            renderStationsTable();
            closeModal('stationModal');
            stationForm.reset();
            alert(`Station "${name}" created successfully!`);
        });
    }

    // News Form Submit
    const newsForm = document.getElementById('news-form');
    if (newsForm) {
        newsForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const title = document.getElementById('news-title').value;
            const category = document.getElementById('news-category').value;
            const author = document.getElementById('news-author').value;
            
            mockNews.unshift({
                title,
                category,
                author,
                date: new Date().toISOString().split('T')[0],
                readTime: "3 mins"
            });
            
            renderNewsTable();
            closeModal('newsModal');
            newsForm.reset();
            alert(`News article "${title}" published!`);
        });
    }

    // Schedule Form Submit
    const scheduleForm = document.getElementById('schedule-form');
    if (scheduleForm) {
        scheduleForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const title = document.getElementById('sched-title').value;
            const presenter = document.getElementById('sched-presenter').value;
            const timeSlot = document.getElementById('sched-time').value;
            
            mockSchedules.unshift({
                title,
                station: "AW Radio Main Stream",
                presenter,
                timeSlot,
                category: "Gospel"
            });
            
            renderSchedulesTable();
            closeModal('scheduleModal');
            scheduleForm.reset();
            alert(`Program "${title}" scheduled!`);
        });
    }

    // Push Notification Form Submit
    const pushForm = document.getElementById('push-form');
    if (pushForm) {
        pushForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const title = document.getElementById('notif-title').value;
            const message = document.getElementById('notif-body').value;
            const targetSelect = document.getElementById('notif-target');
            const target = targetSelect.options[targetSelect.selectedIndex].text;
            
            mockNotifications.unshift({
                title,
                message,
                target,
                date: new Date().toLocaleString(),
                status: "SENT"
            });
            
            renderNotificationsTable();
            pushForm.reset();
            alert(`Push notification broadcast sent to ${target}!`);
        });
    }
});
