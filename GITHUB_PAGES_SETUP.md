# GitHub Pages Kurulum Talimatları

## 1. GitHub Repository Oluşturma

Eğer repository henüz yoksa:

```bash
cd /Users/ridvanarslan/Patern
git init
git add .
git commit -m "Initial commit: PatternWise app with legal documents"
git branch -M main
git remote add origin https://github.com/rdvnrsln/Patern.git
git push -u origin main
```

## 2. GitHub Pages'i Aktif Etme

1. GitHub'da repository'nize gidin: https://github.com/rdvnrsln/Patern
2. **Settings** sekmesine tıklayın
3. Sol menüden **Pages** seçin
4. **Source** bölümünde:
   - **Deploy from a branch** seçin
   - **Branch**: `main` seçin
   - **Folder**: `/docs` seçin
   - **Save** butonuna tıklayın

## 3. URL'ler

GitHub Pages aktif olduktan sonra (birkaç dakika sürebilir), şu URL'ler çalışacak:

- **Privacy Policy**: https://rdvnrsln.github.io/Patern/privacy.html
- **Terms of Use**: https://rdvnrsln.github.io/Patern/terms.html
- **Ana Sayfa**: https://rdvnrsln.github.io/Patern/

## 4. App Store Connect'te Kullanım

App Store Connect > App Privacy bölümünde:

- **Privacy Policy URL**: `https://rdvnrsln.github.io/Patern/privacy.html`
- **Terms of Use URL**: `https://rdvnrsln.github.io/Patern/terms.html`

## 5. Kod İçinde Güncellemeler

Kod içindeki linkler zaten güncellendi:
- ✅ `AppConfiguration.swift` - Privacy Policy ve Terms URL'leri
- ✅ `PaywallView.swift` - Subscription sayfasındaki linkler

## Notlar

- GitHub Pages'in aktif olması birkaç dakika sürebilir
- İlk deploy'dan sonra URL'ler çalışmaya başlar
- `docs/` klasöründeki dosyalar otomatik olarak yayınlanır
- Markdown dosyaları GitHub tarafından otomatik olarak HTML'e çevrilir

