// AW Radio - Interactive iOS Mobile Simulator Engine

const state = {
    currentTab: 'home',
    isPlaying: false,
    currentStation: {
        id: 'station-01',
        name: 'AW Radio Main Stream',
        tagline: 'Listen Live. Anytime. Anywhere.',
        freq: '104.5 FM',
        presenter: 'Pastor David Miller',
        program: 'Morning Glory Drive',
        streamUrl: 'https://stream.zeno.fm/f3wvbbqmdg8uv',
        bannerUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=1000&q=80',
        logoUrl: 'https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?auto=format&fit=crop&w=600&q=80',
        listeners: 4820
    },
    audio: new Audio('https://stream.zeno.fm/f3wvbbqmdg8uv'),
    favorites: ['station-01'],
    selectedCategory: 'All',
    isPlayerExpanded: false
};

const stations = [
    state.currentStation,
    {
        id: 'station-02',
        name: 'AW News & Talk 24/7',
        tagline: 'Your Daily Voice of Truth',
        freq: '98.1 FM',
        presenter: 'Sarah Jenkins',
        program: 'Midday Community Forum',
        streamUrl: 'https://stream.zeno.fm/f3wvbbqmdg8uv',
        bannerUrl: 'https://images.unsplash.com/photo-1495020689067-958852a7765e?auto=format&fit=crop&w=1000&q=80',
        logoUrl: 'https://images.unsplash.com/photo-1585829365295-ab7cd400c167?auto=format&fit=crop&w=600&q=80',
        listeners: 3120
    },
    {
        id: 'station-03',
        name: 'AW Praise & Worship',
        tagline: 'Uplifting Faith & Inspiration',
        freq: '107.9 FM',
        presenter: 'Michael Evans',
        program: 'Evening Worship & Healing',
        streamUrl: 'https://stream.zeno.fm/f3wvbbqmdg8uv',
        bannerUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=1000&q=80',
        logoUrl: 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&w=600&q=80',
        listeners: 6540
    }
];

// Clock Update
function updateClock() {
    const now = new Date();
    const hrs = now.getHours().toString().padStart(2, '0');
    const mins = now.getMinutes().toString().padStart(2, '0');
    const clockEl = document.getElementById('status-clock');
    if (clockEl) clockEl.textContent = `${hrs}:${mins}`;
}

// Audio Controls
function togglePlayPause(stationId = null) {
    if (stationId) {
        const found = stations.find(s => s.id === stationId);
        if (found) state.currentStation = found;
    }
    
    if (state.isPlaying) {
        state.audio.pause();
        state.isPlaying = false;
    } else {
        state.audio.src = state.currentStation.streamUrl;
        state.audio.play().catch(e => console.log('Audio playback policy:', e));
        state.isPlaying = true;
    }
    
    updateUI();
}

function expandPlayer(expand) {
    state.isPlayerExpanded = expand;
    const playerModal = document.getElementById('expanded-player-sheet');
    if (playerModal) {
        playerModal.style.transform = expand ? 'translateY(0)' : 'translateY(100%)';
    }
}

function switchTab(tabName) {
    state.currentTab = tabName;
    document.querySelectorAll('.tab-page').forEach(page => page.style.display = 'none');
    const targetPage = document.getElementById(`page-${tabName}`);
    if (targetPage) targetPage.style.display = 'block';
    
    document.querySelectorAll('.nav-tab').forEach(tab => tab.classList.remove('active'));
    const activeTabBtn = document.getElementById(`tab-btn-${tabName}`);
    if (activeTabBtn) activeTabBtn.classList.add('active');
}

function updateUI() {
    // Dynamic Island State
    const island = document.getElementById('dynamic-island');
    const miniWave = document.getElementById('island-waveform');
    if (island) {
        if (state.isPlaying) {
            miniWave.style.display = 'flex';
            document.getElementById('island-title').textContent = state.currentStation.name;
            document.getElementById('island-sub').textContent = state.currentStation.program;
        } else {
            miniWave.style.display = 'none';
        }
    }

    // Mini Player Bar State
    const miniPlayer = document.getElementById('mini-player-bar');
    if (miniPlayer) {
        miniPlayer.style.display = 'flex';
        document.getElementById('mini-title').textContent = state.currentStation.name;
        document.getElementById('mini-sub').textContent = state.currentStation.program;
        document.getElementById('mini-play-icon').textContent = state.isPlaying ? '⏸' : '▶';
    }

    // Expanded Player State
    document.getElementById('exp-title').textContent = state.currentStation.name;
    document.getElementById('exp-program').textContent = state.currentStation.program;
    document.getElementById('exp-presenter').textContent = `Presenter: ${state.currentStation.presenter}`;
    document.getElementById('exp-play-btn').textContent = state.isPlaying ? '⏸' : '▶';
    document.getElementById('exp-artwork').src = state.currentStation.logoUrl;
    
    // Hero Card Button State
    const heroBtn = document.getElementById('hero-play-btn-text');
    if (heroBtn) heroBtn.textContent = state.isPlaying ? 'PAUSE STREAM' : 'LISTEN LIVE NOW';
}

document.addEventListener('DOMContentLoaded', () => {
    updateClock();
    setInterval(updateClock, 10000);
    switchTab('home');
    updateUI();
});
