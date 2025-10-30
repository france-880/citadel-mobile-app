# 🔍 Quick Connection Test

Run these commands to diagnose the problem:

## 1️⃣ Find Your IP Address

### Windows:
```cmd
ipconfig | findstr /i "IPv4"
```

### Mac/Linux:
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

---

## 2️⃣ Start Backend Correctly

```bash
cd web-app/citadel-backend/citadel-backend
php artisan serve --host=0.0.0.0 --port=8000
```

**Important:** Must use `--host=0.0.0.0` for phone to access!

---

## 3️⃣ Test Backend is Running

### On Computer:
```bash
curl http://127.0.0.1:8000/api/login
```

Should return something (even error is OK).

### On Phone Browser:
Open Chrome/Safari and visit:
```
http://YOUR_IP_HERE:8000/api/login
```
Example: `http://192.168.100.17:8000/api/login`

---

## 4️⃣ If Phone Browser Works but App Doesn't

Update Flutter app:

1. Edit: `lib/services/api_service.dart`
2. Change line 16 to your IP:
   ```dart
   static const String baseUrl = 'http://YOUR_IP:8000/api';
   ```
3. **Rebuild** (not just hot reload):
   ```bash
   flutter run
   ```

---

## 5️⃣ If Phone Browser Doesn't Work

### Windows - Allow Firewall:
```cmd
netsh advfirewall firewall add rule name="Laravel" dir=in action=allow protocol=TCP localport=8000
```

### Check if port is open:
```cmd
netstat -ano | findstr :8000
```

Should show Laravel process listening.

---

## ✅ Quick Checklist

- [ ] Backend running with `--host=0.0.0.0`
- [ ] Phone and computer on same WiFi
- [ ] Used correct IP (192.168.x.x)
- [ ] Tested in phone browser first
- [ ] Rebuilt Flutter app (not just hot reload)
- [ ] Firewall allows port 8000

---

## 🆘 Still Having Issues?

**Most Common Problem:** Not running backend with `--host=0.0.0.0`

**Solution:**
```bash
# ❌ DON'T USE:
php artisan serve

# ✅ USE THIS:
php artisan serve --host=0.0.0.0 --port=8000
```



