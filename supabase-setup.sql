-- ============================================================
--  DÜĞÜN RSVP — SUPABASE KURULUM SQL'İ
--  Bu dosyanın tamamını Supabase panelinde
--  "SQL Editor" bölümüne yapıştırıp "Run" deyin.
-- ============================================================

-- 1) RSVP tablosu
create table if not exists public.rsvp (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  phone       text not null,
  attendance  text not null check (attendance in ('yes','no')),
  guest_count integer not null default 0,
  guest_names text,
  note        text,
  created_at  timestamptz not null default now()
);

-- Daha önce tablo oluşturduysanız, bu satır eksik kolonu ekler:
alter table public.rsvp add column if not exists guest_names text;

-- 2) Row Level Security'i aç
alter table public.rsvp enable row level security;

-- 3) Güvenlik kuralları (politikalar)

-- (a) HERKES yeni kayıt EKLEYEBİLİR (davetli formu için).
--     Ama kimse başkasının kaydını okuyamaz/silemez.
drop policy if exists "public can insert rsvp" on public.rsvp;
create policy "public can insert rsvp"
  on public.rsvp for insert
  to anon, authenticated
  with check (true);

-- (b) Yalnızca GİRİŞ YAPMIŞ admin kayıtları OKUYABİLİR.
drop policy if exists "auth can read rsvp" on public.rsvp;
create policy "auth can read rsvp"
  on public.rsvp for select
  to authenticated
  using (true);

-- (c) Yalnızca giriş yapmış admin GÜNCELLEYEBİLİR.
drop policy if exists "auth can update rsvp" on public.rsvp;
create policy "auth can update rsvp"
  on public.rsvp for update
  to authenticated
  using (true) with check (true);

-- (d) Yalnızca giriş yapmış admin SİLEBİLİR.
drop policy if exists "auth can delete rsvp" on public.rsvp;
create policy "auth can delete rsvp"
  on public.rsvp for delete
  to authenticated
  using (true);

-- ============================================================
--  BİTTİ.
--  Not: Normal ziyaretçiler (anon) sadece ekleme yapabilir;
--  listeyi göremez, düzenleyemez, silemez.
--  Bunları yalnızca giriş yapmış admin yapabilir.
-- ============================================================
