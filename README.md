# Habit Tracker App

Sebuah aplikasi mobile untuk melacak kebiasaan (habit) harian, dibangun menggunakan Flutter dengan state management GetX.

---

## 🚀 Cara Menjalankan

Berikut adalah langkah-langkah untuk menjalankan proyek ini di lingkungan pengembangan Anda:

1.  **Pastikan Flutter terinstal**
    Jika belum, instal Flutter SDK dari [situs resmi Flutter](https://flutter.dev/docs/get-started/install).

2.  **Clone Repository**
    ```bash
    git clone [https://github.com/HenryPutra/habit_tracker_app.git](https://github.com/HenryPutra/habit_tracker_app.git)
    cd habit_tracker_app
    ```

3.  **Install Dependencies**
    Jalankan perintah berikut di terminal dari dalam folder proyek:
    ```bash
    flutter pub get
    ```

4.  **Jalankan Aplikasi**
    Pastikan emulator Anda berjalan atau perangkat fisik terhubung, lalu jalankan:
    ```bash
    flutter run
    ```

---

## 📂 Struktur Folder (lib)

Proyek ini menggunakan struktur yang berfokus pada fitur (feature-first) dengan GetX Pattern. Berikut adalah gambaran struktur folder `lib`:

```
lib
├── app
│   ├── modules
│   │   ├── add_habit     # Fitur Menambah Habit
│   │   ├── edit_habit    # Fitur Mengedit Habit
│   │   ├── home          # Modul Halaman Utama (Dashboard)
│   │   ├── login         # Modul Halaman Login/Autentikasi
│   │   └── progress      # Modul Halaman Progress/Statistik
│   │
│   └── routes
│       ├── app_pages.dart  # Kumpulan semua halaman/routes
│       └── app_routes.dart # Definisi nama-nama rute
│
├── models                # Berisi model data (POJO/Dart Objects)
│
└── main.dart             # Entry point / titik awal aplikasi
```

### Penjelasan Singkat

* **`main.dart`**: Titik masuk utama aplikasi. Berfungsi untuk menginisialisasi aplikasi dan GetMaterialApp.
* **`app/modules/`**: Direktori utama yang berisi semua fitur aplikasi. Setiap folder di dalamnya (seperti `home`, `login`) adalah modul yang berdiri sendiri.
* **`app/routes/`**: Mengelola semua navigasi dan rute halaman dalam aplikasi menggunakan GetX.
* **`models/`**: (Opsional, tapi umum) Berisi kelas model data, misalnya `HabitModel.dart`.
