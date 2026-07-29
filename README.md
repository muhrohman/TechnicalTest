Technical Test

Aplikasi manajemen stok barang berbasis web

## Tech Stack

- **Backend:** Laravel (PHP 8.4)
- **Frontend:** Vue 3 (Composition API)
- **Styling:** Tailwind CSS 3
- **Database:** MySQL
- **Authentication:** Laravel Session (Stateful)

---

## Persyaratan Sistem

- PHP >= 8.4 (Wajib)
- Composer
- Node.js & npm (v18+)
- MySQL
- Gunakan Nginx (Wajib)

---

## Cara Instalasi

**1. Clone / Ekstrak Project**
Buka terminal dan arahkan ke folder project ini.

**2. Install Dependencies**

```bash
composer install
npm install
```

**3. Setup Environment**
Copy file `.env.example` menjadi `.env`:

```bash
cp .env.example .env
```

Sesuaikan konfigurasi koneksi database di file `.env`:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=teknikal_test
DB_USERNAME=root
DB_PASSWORD=

# Pastikan session dan cache menggunakan file agar tidak butuh tabel tambahan
SESSION_DRIVER=file
CACHE_STORE=file
QUEUE_CONNECTION=sync
```

**4. Generate Key**

```bash
php artisan key:generate
```

**5. Setup Database**
Ada dua cara untuk setup database:

- **Cara 1 (Rekomendasi):** Import file `teknikal_test.sql` yang ada di folder root project ke dalam database MySQL Anda. File ini sudah berisi struktur tabel dan data terbaru.
- **Cara 2:** Jalankan perintah migrate dan seed bawaan Laravel:
    ```bash
    php artisan migrate:fresh --seed
    ```

**6. Build Frontend Assets**

```bash
npm run build
```

**7. Jalankan Aplikasi**
Jika menggunakan Herd/Valet, aplikasi bisa langsung diakses lewat domain `.test`. Jika tidak, jalankan server bawaan Laravel:

```bash
php artisan serve
```

Buka browser dan akses `http://localhost:8000`.

---

## Akses Login (Admin)

Gunakan kredensial berikut untuk masuk ke dalam sistem:

- **Username:** `admin`
- **Password:** `password`
