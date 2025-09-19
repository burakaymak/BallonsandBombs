# 🎈💣 Balloons and Bombs

**Balloons and Bombs**, Swift ve SpriteKit kullanılarak geliştirilmiş basit bir **arcade tıklama oyunu**dur. Oyuncu, ekrana dokunarak balonları patlatır ve bombalardan kaçınarak en yüksek skoru elde etmeye çalışır.  

---

## 🚀 Özellikler
- 🎮 **Balonları patlatma** ve **bombalardan kaçınma** mekanikleri
- ⏱ **Zaman sayacı** ile sınırlı oyun süresi (varsayılan: 45 saniye)
- 📈 **Skor ve seviye sistemi** (Level 1 → Level 2 → …)
- ⚡ Level atlandıkça **spawn hızı** artar ve **yok olma süresi** azalır
- 🔄 **Retry Button** ile oyunu yeniden başlatma
- 🧩 **SpriteKit** ve **SKAction** kullanımı

---

## 🖼 Oyun Ekranı
- Üst kısım: **Skor ve zaman sayacı**
- Orta kısım: **Oyun sahnesi** (balonlar ve bombalar)
- Başlangıç: **Start Button** ve oyun ismi  
- Oyun bitince: **Retry Button** aktif olur
- Level geçişinde: **Level Label** ekranda gösterilir

---

## 🎮 Nasıl Oynanır?
1. Oyunu başlatın ve **Start** butonuna dokunun.
2. Balonlara dokunun → **skor artar**.
3. Bombalara dokunun → **skor düşer**.
4. Belirli bir skora ulaşınca **sonraki level** başlar.  
   - Spawn hızı artar ve objeler daha hızlı yok olur.
5. Süre dolduğunda oyun biter ve **Retry** butonu aktif olur.
6. Retry ile oyun sıfırlanır ve Level 1’den tekrar başlar.

---

## ⚙️ Level Mekaniği
- **spawnSpeed**: Objelerin sahneye çıkma hızı (level ilerledikçe azalır → daha hızlı)
- **disappearTime**: Objelerin otomatik yok olma süresi (level ilerledikçe azalır → daha hızlı kaybolur)
- Level geçişi için varsayılan skor: 20

---

## 🛠 Kullanılan Teknolojiler
- **Swift 5**
- **SpriteKit**
- **SKAction** (fade, remove, sequence)
- **Timer** (spawn ve countdown yönetimi)
- **SKLabelNode** (Skor, Level, Time, Retry Button)
- **SKSpriteNode** (balon ve bombalar)

---

## 📂 Proje Yapısı
```plaintext
BalloonsAndBombs/
│
├── GameScene.swift      # Oyun mekaniği, spawn ve level yönetimi
├── Assets.xcassets      # Balon ve bombalar için görseller
└── GameScene.sks        # Sahne tasarımı, buton ve label konumları
