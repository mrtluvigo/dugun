// ============================================================
//  SUPABASE AYARLARI  —  BURAYI DOLDURUN
// ============================================================
//
//  Supabase panelinizde:  Project Settings > API  bölümünden
//  aşağıdaki iki değeri kopyalayıp buraya yapıştırın.
//
//  ⚠️  Buradaki "anon key" gizli DEĞİLDİR — herkese açık olacak
//      şekilde tasarlanmıştır. Güvenlik, Supabase tarafındaki
//      "Row Level Security (RLS)" kuralları ile sağlanır.
//      (Kurulum adımlarındaki SQL bunu ayarlar.)
//
//  ⚠️  SERVICE ROLE KEY'İ BURAYA ASLA YAZMAYIN.
//      O anahtar yalnızca Supabase panelinde kalır.
// ============================================================

const SUPABASE_URL = "https://zavsricdzdepummzfgbm.supabase.co";      // örn: https://xxxxxxxx.supabase.co
const SUPABASE_ANON_KEY = "sb_publishable_RL0mBxszUat33IvP0Uvzsw_KS5FNYAE";     // uzun bir anahtar

// Bu satırları değiştirmenize gerek yok:
window.__WEDDING_CONFIG__ = { SUPABASE_URL, SUPABASE_ANON_KEY };
