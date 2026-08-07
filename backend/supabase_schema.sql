-- AW Radio Database Schema for PostgreSQL / Supabase
-- Enables extension for UUID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Users Table
CREATE TABLE IF NOT EXISTS public.users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    full_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    avatar TEXT,
    role TEXT NOT NULL DEFAULT 'user' CHECK (role IN ('user', 'presenter', 'admin')),
    favorite_station_id UUID,
    total_listening_minutes INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Stations Table
CREATE TABLE IF NOT EXISTS public.stations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    tagline TEXT,
    description TEXT,
    logo TEXT NOT NULL,
    banner TEXT NOT NULL,
    stream_url TEXT NOT NULL,
    website TEXT,
    category TEXT NOT NULL DEFAULT 'Gospel',
    is_live BOOLEAN DEFAULT TRUE,
    active_listeners INTEGER DEFAULT 0,
    frequency TEXT DEFAULT '104.5 FM',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Programs Table (Schedules)
CREATE TABLE IF NOT EXISTS public.programs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    station_id UUID REFERENCES public.stations(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    presenter TEXT NOT NULL,
    presenter_avatar TEXT,
    banner TEXT,
    start_time TIMESTAMP WITH TIME ZONE NOT NULL,
    end_time TIMESTAMP WITH TIME ZONE NOT NULL,
    category TEXT DEFAULT 'Gospel',
    is_live_now BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. News Table
CREATE TABLE IF NOT EXISTS public.news (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    summary TEXT NOT NULL,
    content TEXT NOT NULL,
    image TEXT NOT NULL,
    category TEXT NOT NULL DEFAULT 'General',
    author TEXT DEFAULT 'AW Media Desk',
    read_time_minutes INTEGER DEFAULT 3,
    published_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. Podcasts Table
CREATE TABLE IF NOT EXISTS public.podcasts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    description TEXT,
    presenter TEXT NOT NULL,
    audio_file TEXT NOT NULL,
    artwork TEXT NOT NULL,
    duration INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. Favorites Table
CREATE TABLE IF NOT EXISTS public.favorites (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
    item_type TEXT NOT NULL CHECK (item_type IN ('station', 'program', 'news')),
    item_reference_id TEXT NOT NULL,
    title TEXT NOT NULL,
    subtitle TEXT,
    image_url TEXT,
    added_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, item_reference_id)
);

-- 7. Notifications Table
CREATE TABLE IF NOT EXISTS public.notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    image TEXT,
    category TEXT DEFAULT 'System Updates',
    sent_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
