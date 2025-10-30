# 📱 Mobile Phone Testing Guide - Connection Troubleshooting

## 🚨 Current Issue: ERR_CONNECTION_REFUSED

Your mobile phone cannot connect to the backend server at `http://192.168.100.17:8000/api`

---

## ✅ Step-by-Step Troubleshooting

### **Step 1: Check if Backend is Running** 🔴 MOST COMMON ISSUE

1. Open terminal/command prompt
2. Navigate to backend folder:
   ```bash
   cd web-app/citadel-backend/citadel-backend
   ```

3. **IMPORTANT:** Start server with `--host=0.0.0.0` to accept external connections:
   ```bash
   php artisan serve --host=0.0.0.0 --port=8000
   ```

   ❌ **DON'T USE:**
   ```bash
   php artisan serve  # Only accepts localhost connections!
   ```

   ✅ **USE THIS:**
   ```bash
   php artisan serve --host=0.0.0.0 --port=8000
   ```

4. You should see:
   ```
   INFO  Server running on [http://0.0.0.0:8000].
   ```

---

### **Step 2: Find Your Computer's IP Address** 📍

#### **For Windows:**
1. Open Command Prompt (CMD)
2. Run: `ipconfig`
3. Look for **"IPv4 Address"** under your WiFi adapter
4. Example: `192.168.1.100`

```cmd
C:\> ipconfig

Wireless LAN adapter Wi-Fi:
   IPv4 Address. . . . . . . . . . . : 192.168.1.100  ← THIS IS YOUR IP!
```

#### **For Mac/Linux:**
1. Open Terminal
2. Run: `ifconfig` or `ip addr show`
3. Look for IP starting with `192.168.x.x` or `10.x.x.x`

```bash
$ ifconfig
en0: flags=8863<UP,BROADCAST,SMART,RUNNING>
    inet 192.168.1.100  ← THIS IS YOUR IP!
```

---

### **Step 3: Update API Base URL** 🔧

1. Open: `mobile-app/citadel-mobile-app/lib/services/api_service.dart`

2. Update line 16 with your IP address:
   ```dart
   static const String baseUrl = 'http://YOUR_IP_HERE:8000/api';
   ```

   **Example:**
   ```dart
   static const String baseUrl = 'http://192.168.1.100:8000/api';
   ```

3. Save the file

4. **IMPORTANT:** Rebuild the app (not just hot reload):
   ```bash
   flutter run
   ```

---

### **Step 4: Check Network Connection** 🌐

#### **Make sure:**
1. ✅ Your phone and computer are on the **SAME WiFi network**
2. ✅ Not using mobile data on phone
3. ✅ WiFi is enabled on both devices

#### **How to check on phone:**
- Go to WiFi settings
- Check connected network name
- Should match your computer's WiFi network

---

### **Step 5: Test Backend Connection** 🧪

#### **Test from Computer (should work):**
Open browser and visit:
```
http://192.168.1.100:8000/api/login
```
(Replace with your actual IP)

**Expected:** Should show something (even an error is OK, means server is running)

#### **Test from Phone Browser:**
1. Open Chrome/Safari on your phone
2. Type in address bar:
   ```
   http://192.168.1.100:8000/api/login
   ```
   (Replace with your actual IP)

3. **If it works:** Backend is accessible! Problem is in app.
4. **If it doesn't work:** See firewall section below.

---

### **Step 6: Check Windows Firewall** 🛡️ (If using Windows)

#### **Allow Laravel through firewall:**

1. **Open Command Prompt as Administrator**

2. Run these commands:
   ```cmd
   netsh advfirewall firewall add rule name="Laravel Server" dir=in action=allow protocol=TCP localport=8000
   ```

   OR

3. **Using Windows Firewall GUI:**
   - Search "Windows Defender Firewall" in Start menu
   - Click "Advanced settings"
   - Click "Inbound Rules" → "New Rule"
   - Select "Port" → Next
   - Select "TCP" → Specific local ports: `8000` → Next
   - Select "Allow the connection" → Next
   - Check all profiles → Next
   - Name: "Laravel Backend" → Finish

---

### **Step 7: Verify Laravel .env Settings** ⚙️

Check `web-app/citadel-backend/citadel-backend/.env`:

```env
APP_URL=http://0.0.0.0:8000
# Or use your IP:
# APP_URL=http://192.168.1.100:8000

# Make sure these are set:
SANCTUM_STATEFUL_DOMAINS=*
SESSION_DOMAIN=.yourdomain.com  # or leave blank for local testing
```

---

## 🔍 Common Error Messages

### **ERR_CONNECTION_REFUSED**
**Means:** Backend server is not running or not accessible
**Fix:** Check Step 1 - Make sure backend is running with `--host=0.0.0.0`

### **ERR_CONNECTION_TIMED_OUT**
**Means:** Firewall is blocking the connection
**Fix:** Check Step 6 - Configure Windows Firewall

### **ERR_NAME_NOT_RESOLVED**
**Means:** Wrong IP address or DNS issue
**Fix:** Double-check IP address from Step 2

### **Network Error: Connection refused**
**Means:** App can't reach the backend
**Fix:** Make sure phone and computer are on same WiFi network

---

## 📋 Quick Checklist

Before testing on mobile phone:

- [ ] Backend server is running with `php artisan serve --host=0.0.0.0 --port=8000`
- [ ] Found computer's IP address (192.168.x.x)
- [ ] Updated `api_service.dart` with correct IP
- [ ] Rebuilt the Flutter app (not just hot reload)
- [ ] Phone and computer on same WiFi network
- [ ] Tested backend in phone's browser (http://YOUR_IP:8000/api/login)
- [ ] Windows Firewall allows port 8000 (if applicable)
- [ ] Backend shows no errors in terminal

---

## 🎯 Recommended Testing Flow

### **1. Test Backend Accessibility:**
```bash
# On computer terminal:
cd web-app/citadel-backend/citadel-backend
php artisan serve --host=0.0.0.0 --port=8000
```

### **2. Test from Phone Browser:**
```
http://YOUR_COMPUTER_IP:8000/api/login
```

### **3. If browser works, update Flutter app:**
```dart
// lib/services/api_service.dart
static const String baseUrl = 'http://YOUR_COMPUTER_IP:8000/api';
```

### **4. Rebuild app:**
```bash
flutter run
```

---

## 🆘 Still Not Working?

### **Try these diagnostic commands:**

#### **On Computer (Windows):**
```cmd
# Check if Laravel is running:
netstat -ano | findstr :8000

# Test localhost connection:
curl http://127.0.0.1:8000/api/login

# Test network connection:
curl http://192.168.1.100:8000/api/login
```

#### **On Phone:**
Download "Network Analyzer" app and:
1. Ping your computer's IP
2. Check if port 8000 is open
3. Verify WiFi connection

---

## 💡 Pro Tips

1. **Use ngrok for easier testing:**
   ```bash
   ngrok http 8000
   ```
   Then use the ngrok URL in your app (works from anywhere!)

2. **Keep Laravel terminal visible:**
   - Watch for incoming requests
   - Check for errors in real-time

3. **Use Flutter DevTools:**
   - Monitor network requests
   - See actual error messages

4. **Test incrementally:**
   - First: Test backend in browser
   - Second: Test backend in phone browser
   - Third: Test Flutter app
   - This helps identify where the problem is

---

## 📱 Current Configuration

**Base URL:** `http://192.168.100.17:8000/api`

**To change:**
1. Edit: `mobile-app/citadel-mobile-app/lib/services/api_service.dart`
2. Update line 16
3. Rebuild app

---

*Last Updated: October 28, 2025*
*For mobile phone testing support*



