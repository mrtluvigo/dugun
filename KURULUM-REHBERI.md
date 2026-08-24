# Düğün Sitesi + Davetli Yönetimi — Kurulum Rehberi

Merhaba! Bu rehber, düğün sitenizi ve davetli yönetim panelinizi
**tamamen ücretsiz** şekilde canlıya almanız için hazırlandı.
Teknik bilgi gerektirmez; adımları sırayla takip etmeniz yeterli.

Toplam süre: yaklaşık **15–20 dakika**.

Kullanılan ücretsiz servisler:
- **Supabase** — davetli cevaplarının saklandığı veritabanı
- **Netlify** (veya Vercel) — sitenin yayınlandığı yer

---

## Dosyalarınız

```
/
├── index.html              → Düğün davetiye sitesi (davetliler bunu görür)
├── config.js               → Supabase bilgilerinizi buraya yazacaksınız
├── supabase-setup.sql      → Veritabanı tablosunu kuran hazır kod
├── .env.example            → Bilgi notu (dokunmanıza gerek yok)
└── admin/
    ├── login.html          → Admin giriş sayfası
    └── dashboard.html      → Davetli yönetim paneli
```

---

## ADIM 1 — Supabase hesabı ve proje oluşturma

1. https://supabase.com adresine gidin, **"Start your project"** deyin.
2. GitHub veya e-posta ile ücretsiz kayıt olun.
3. **"New Project"** deyin.
   - **Name:** dugun (ya da istediğiniz bir isim)
   - **Database Password:** güçlü bir şifre belirleyin ve bir yere not edin
   - **Region:** *Frankfurt (eu-central)* seçin (Türkiye'ye en yakın)
4. **"Create new project"** deyin. Proje 1–2 dakikada hazır olur.

---

## ADIM 2 — Veritabanı tablosunu oluşturma

1. Supabase panelinde sol menüden **SQL Editor**'e girin.
2. **"New query"** deyin.
3. Bilgisayarınızdaki **`supabase-setup.sql`** dosyasını bir metin
   editörüyle açın, **tüm içeriğini kopyalayın**.
4. SQL Editor'e yapıştırın ve sağ alttaki **"Run"** düğmesine basın.
5. "Success" yazısını görürseniz tablo ve güvenlik kuralları hazır demektir.

> Bu adım `rsvp` tablosunu oluşturur ve güvenliği ayarlar:
> davetliler yalnızca **yeni kayıt ekleyebilir**, listeyi göremez.
> Listeyi yalnızca **siz (admin)** görebilirsiniz.

---

## ADIM 3 — Bağlantı anahtarlarını alma ve config.js'e yazma

1. Supabase panelinde sol menüden **Project Settings** (dişli simgesi) →
   **API** bölümüne girin.
2. Şu iki değeri kopyalayın:
   - **Project URL** (örn: `https://abcdefgh.supabase.co`)
   - **anon public** anahtarı (uzun bir yazı)
3. Bilgisayarınızda **`config.js`** dosyasını açın.
4. İçindeki iki satırı kendi değerlerinizle değiştirin:

```js
const SUPABASE_URL = "https://abcdefgh.supabase.co";   // kendi URL'iniz
const SUPABASE_ANON_KEY = "eyJhbGciOi...";              // kendi anon key'iniz
```

5. Dosyayı kaydedin.

> **Not:** `anon` anahtarı gizli değildir; herkese açık olması normaldir.
> Güvenlik, ADIM 2'de kurduğunuz kurallarla sağlanır.
> **Service Role Key**'i hiçbir yere yazmayın; ona ihtiyacınız yok.

---

## ADIM 4 — Admin kullanıcı hesabı oluşturma

Panele girmek için bir kullanıcı (siz) oluşturmalısınız:

1. Supabase panelinde sol menüden **Authentication** → **Users** bölümüne girin.
2. Sağ üstten **"Add user"** → **"Create new user"** deyin.
3. Bir **e-posta** ve **şifre** girin (bunlar sizin admin giriş bilgileriniz olacak).
4. **"Auto Confirm User"** seçeneğini **işaretleyin** (e-posta doğrulaması istemesin).
5. **"Create user"** deyin.

> Bu e-posta ve şifre ile admin paneline gireceksiniz.
> Dilerseniz eşiniz için ikinci bir kullanıcı da ekleyebilirsiniz.

---

## ADIM 5 — Siteyi ücretsiz yayınlama (Netlify)

En kolay yöntem — sürükle-bırak:

1. https://app.netlify.com/drop adresine gidin (ücretsiz kayıt olun).
2. **`config.js` dosyasını doldurduktan sonra**, tüm proje klasörünü
   (içindeki `index.html`, `config.js`, `admin` klasörü dahil)
   bu sayfaya **sürükleyip bırakın**.
3. Netlify birkaç saniyede size bir adres verir, örneğin:
   `https://sumeyye-emircan.netlify.app`
4. Bu adres artık **canlı düğün sitenizdir**. 🎉

> İsterseniz Netlify panelinden **Site settings → Change site name**
> ile adresi güzelleştirebilirsiniz (örn: `sumeyye-emircan-dugun`).
>
> Alternatif olarak **Vercel** de kullanılabilir (vercel.com),
> aynı şekilde klasörü yükleyerek.

---

## ADIM 6 — Kullanım

**Davetli tarafı:**
- Davetlilere sitenizin adresini gönderin (WhatsApp, SMS vb.).
- Formu doldurup "Katılımımı Bildir" deyince cevap veritabanına düşer.

**Sizin (admin) tarafınız:**
- Yönetim paneline şu adresten girersiniz:

```
https://SITE-ADRESINIZ/admin/login.html
```

  Örnek: `https://sumeyye-emircan.netlify.app/admin/login.html`

- ADIM 4'te oluşturduğunuz **e-posta ve şifre** ile giriş yapın.
- Panelde: toplam yanıt, katılacak/katılmayacak sayıları,
  toplam katılımcı, düğüne kalan gün, arama/filtre, düzenleme/silme
  ve **"Davetli Listesini İndir"** (Excel'de açılan CSV) bulunur.

---

## Sık sorulanlar

**S: Davetliler birbirinin cevabını görebilir mi?**
Hayır. Güvenlik kuralları gereği davetliler yalnızca kendi kaydını
ekler; kimse listeyi göremez. Listeyi sadece giriş yapan admin görür.

**S: Form gönderilmiyor / "sistem bağlanmadı" diyor.**
`config.js` içindeki URL ve anon key doğru yazılmamış olabilir.
ADIM 3'ü tekrar kontrol edin ve siteyi yeniden yükleyin.

**S: Panele girince liste boş / "yetkiniz yok" diyor.**
ADIM 2'deki SQL'i çalıştırdığınızdan ve ADIM 4'te kullanıcı
oluşturduğunuzdan emin olun.

**S: Katılacak kişilerin isimleri nereye kaydediliyor?**
"Katılacağım" seçilince kişi sayısı kadar isim alanı açılır. Bu isimler
`guest_names` sütununa kaydedilir ve admin panelinde "Katılacaklar"
sütununda + Excel çıktısında görünür.

**S: Daha önce tabloyu kurmuştum, isim sütunu yok.**
`supabase-setup.sql` dosyasını tekrar çalıştırın; içindeki
`alter table ... add column if not exists guest_names` satırı
eksik sütunu güvenle ekler (mevcut verilere zarar vermez).

---

Hazır! Sorularınız olursa adımları tekrar gözden geçirin;
her şey sırayla yapıldığında sorunsuz çalışır. Mutluluklar dilerim. ♥
