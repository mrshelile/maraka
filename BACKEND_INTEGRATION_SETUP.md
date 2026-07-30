# Flutter Backend Integration Setup Checklist

## ✅ What's Already Done

- [x] Created `PromotionFlyer` model (deserializes backend JSON)
- [x] Created `PromotionFlyerService` (API calls + caching)
- [x] Created `RealPromotionsBanner` (home page carousel)
- [x] Created `RealPromotionsPage` (promotions tab)
- [x] Created `PromotionDetailsDialog` (view full promotion)
- [x] Updated `home.dart` to use real promotions
- [x] Updated `DiscountBanner` to fetch from API
- [x] Added error handling, loading states, refresh support

## 🚀 To Get It Working

### Step 1: Verify Backend is Running
```bash
# On Django terminal, run:
python manage.py runserver 0.0.0.0:8000
```
Verify: `curl http://192.168.1.59:8000/buyandsellDjango-apis/promotion-flyers`

### Step 2: Ensure Flutter App Can Reach Backend
- App runs on same network as Django server
- Backend URL in `lib/service/promotion_flyer_service.dart`:
  ```dart
  static const String backendBaseUrl = 'http://192.168.1.59:8000';
  ```
- Update if using different network/IP

### Step 3: Get Pub Dependencies
```bash
cd F:\Documents\Projects Worked On\maraka
flutter pub get
```

### Step 4: Run Flutter App
```bash
flutter run
```

### Step 5: Test the Integration
1. **Home Page:**
   - Should show promotional carousel above categories
   - Tap to see full promotion
   - Auto-rotates every 4 seconds

2. **Promotions Tab:**
   - Should show grid of all active promotions
   - Pull down to refresh
   - Tap promotion to open details

3. **Backend Admin:**
   - Go to `http://192.168.1.59:8000/admin`
   - Navigate to Content → Banners or Featured Ads
   - Add/edit promotions with:
     - Owner: "Maraka"
     - Link: "https://maraka.co.ls"
     - Home: ✓ (checked)
     - Splashscreen: ✓ (checked)
     - Expire Date: Tomorrow or later

## 📋 File Structure

```
lib/
├── models/
│   ├── promotion_flyer.dart          ← NEW: API model
│   └── ...existing models
├── service/
│   ├── promotion_flyer_service.dart  ← NEW: API calls
│   └── ...existing services
├── pages/
│   ├── home/
│   │   ├── promotions_real.dart      ← NEW: Real promo UI
│   │   ├── components/
│   │   │   └── top_banner.dart       ← UPDATED: Uses API
│   │   └── ...existing components
│   └── ...existing pages
└── screens/
    └── home.dart                      ← UPDATED: Uses RealPromotionsPage
```

## 🔌 Backend API Contract

**Endpoint:** `GET /buyandsellDjango-apis/promotion-flyers`

**Response:** Array of promotions
```json
[
  {
    "id": 1,
    "type": "promotion",
    "title": "Maraka",
    "link": "https://maraka.co.ls",
    "image_url": "http://192.168.1.59:8000/uploads/maraka_flyer.jpg",
    "splashscreen": true,
    "home": true,
    "owner": "Maraka",
    "expire_date": "2024-12-31T23:59:59Z"
  }
]
```

## 🎯 Key Features

| Feature | Location | Notes |
|---------|----------|-------|
| Home Page Banner | `DiscountBanner` (updated) | Auto-rotating carousel |
| Promotions Tab | `RealPromotionsPage` | List with pull-to-refresh |
| Details Dialog | `PromotionDetailsDialog` | Full image + action button |
| API Service | `PromotionFlyerService` | Handles caching + filtering |
| Data Model | `PromotionFlyer` | Deserializes JSON |

## 🔄 Data Flow

```
Backend Admin
    ↓
Django ORM (Banner/FeaturedAd models)
    ↓
REST API (/promotion-flyers endpoint)
    ↓
HTTP GET from Flutter
    ↓
PromotionFlyerService
    ↓
Parse JSON → PromotionFlyer objects
    ↓
Cache (5 minutes)
    ↓
FilterUI Components
    ↓
Display in App
```

## 💾 Caching

- **Duration:** 5 minutes
- **Manual Clear:** Pull-to-refresh button
- **Automatic:** Service checks age on each fetch

## ⚠️ Common Issues

| Issue | Solution |
|-------|----------|
| "No Active Promotions" message | Add promotions via Django admin with home=true |
| Images not loading | Check /uploads/ directory, verify image URLs in admin |
| Connection timeout | Verify backend running on 192.168.1.59:8000 |
| Blank carousel | Ensure ≥1 promotion has home=true and not expired |
| "Error Loading Promotions" | Tap retry button or pull-to-refresh |

## 📱 User Experience

### First Time
1. User opens app → Home page loads
2. Carousel shows loading spinner briefly
3. First promotion appears with auto-rotation
4. User sees real admin-managed content

### Promotions Tab
1. User taps "Promotions" → List of all active promos
2. User taps one → Full-screen dialog
3. User taps "Visit Link" → Opens in browser
4. User pulls down → Refreshes from backend

## 🛠️ Development Commands

```bash
# Run tests
flutter test

# Run app
flutter run

# Check for build errors
flutter analyze

# View logs
flutter logs

# Clear cache & rebuild
flutter clean
flutter pub get
flutter run
```

## 📝 Next Steps

1. **Verify setup** following steps above
2. **Test API** endpoint with Postman or browser
3. **Add test promotions** via Django admin
4. **Run Flutter app** and verify displaying correctly
5. **Check error cases** (no promotions, network down, etc.)
6. **Optional:** Add custom branding/colors if needed

## ❓ Questions?

Refer to `FLUTTER_BACKEND_INTEGRATION.md` for detailed documentation on:
- Architecture overview
- Component descriptions
- Error handling strategy
- Caching mechanism
- Performance optimization tips
