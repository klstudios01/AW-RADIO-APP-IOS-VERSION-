-- AW Radio Row-Level Security (RLS) Policies for Supabase

-- Enable RLS on all tables
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.stations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.programs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.news ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.podcasts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- 1. Public Read Access Policies (Stations, Programs, News, Podcasts, Notifications)
CREATE POLICY "Public stations are readable by everyone" ON public.stations FOR SELECT USING (true);
CREATE POLICY "Public programs are readable by everyone" ON public.programs FOR SELECT USING (true);
CREATE POLICY "Public news are readable by everyone" ON public.news FOR SELECT USING (true);
CREATE POLICY "Public podcasts are readable by everyone" ON public.podcasts FOR SELECT USING (true);
CREATE POLICY "Public notifications are readable by everyone" ON public.notifications FOR SELECT USING (true);

-- 2. Favorites User Ownership Policies
CREATE POLICY "Users can view their own favorites" ON public.favorites FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert their own favorites" ON public.favorites FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can delete their own favorites" ON public.favorites FOR DELETE USING (auth.uid() = user_id);

-- 3. Users Profile Policies
CREATE POLICY "Users can view their own profile" ON public.users FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update their own profile" ON public.users FOR UPDATE USING (auth.uid() = id);

-- 4. Admin Management Policies (Requires Admin Role)
CREATE POLICY "Admins can manage all stations" ON public.stations FOR ALL USING (
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'admin')
);
CREATE POLICY "Admins can manage all programs" ON public.programs FOR ALL USING (
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'admin')
);
CREATE POLICY "Admins can manage all news" ON public.news FOR ALL USING (
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'admin')
);
