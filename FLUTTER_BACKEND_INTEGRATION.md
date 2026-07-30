# Flutter-Django Backend Integration Guide

## Overview

The Maraka Flutter app has been updated to fetch real promotion flyers from the Django backend instead of using mock data.

## What Was Added to the Flutter App

### 1. **Promotion Flyer Model** (`lib/models/promotion_flyer.dart`)

A data model that represents a promotion flyer from the backend API:

```dart
class PromotionFlyer {
  final int id;
  final String type; // Always "promotion"
  final String title; // Owner name
  final String link; // URL to visit
  final String imageUrl; // Absolute image URL
  final bool splashscreen; // Show on splash/startup
  final bool home; // Show on home page
  final String owner; // Business owner
  final DateTime? expireDate; // Expiry date
  
  bool get isActive => expireDate == null || expireDate!.isAfter(DateTime.now());
  int get daysUntilExpiry => /* days until expiration */;
}
```

**Features:**
- JSON deserialization from backend API
- Expiry checking
- Days until expiry calculation

### 2. **Promotion Flyer Service** (`lib/service/promotion_flyer_service.dart`)

API service that handles communication with the Django backend:

```dart
class PromotionFlyerService {
  static const String backendBaseUrl = 'http://192.168.1.59:8000';
  static const String promotionEndpoint = '/buyandsellDjango-apis/promotion-flyers';
  
  // Static methods
  static Future<List<PromotionFlyer>> fetchPromotionFlyers()
  static Future<List<PromotionFlyer>> fetchSplashScreenFlyers()
  static Future<List<PromotionFlyer>> fetchHomePageFlyers()
  static Future<List<PromotionFlyer>> fetchFlyersByOwner(String owner)
  static void clearCache()
}
```

**Features:**
- Fetches all promotions from backend
- Filters by display type (splashscreen, home)
- 5-minute caching to reduce API calls
- Automatic expiry filtering (only returns active promotions)
- Sorting by expiry date
- Error handling & retry support

### 3. **Real Promotions UI Components** (`lib/pages/home/promotions_real.dart`)

New Flutter widgets for displaying real promotion flyers:

#### **RealPromotionsBanner** (Home Page Carousel)
- Auto-rotating carousel of home promotions
- Shows on home page above categories
- Displays loading states
- Tap to view full details
- Close button to dismiss

#### **RealPromotionsPage** (Promotions Tab)
- Grid/list view of all active promotions
- Pull-to-refresh to reload from backend
- Error handling with retry button
- Empty state when no promotions available
- Shows days until expiry for each promotion

#### **PromotionDetailsDialog**
- Full-screen promotion image viewer
- Title, owner, expiry information
- "Visit Link" button to open promotion link
- Dismissible

### 4. **Updated Components**

#### **`lib/screens/home.dart`**
- Changed import from `promotions.dart` → `promotions_real.dart`
- Changed widget from `PromotionsPage()` → `RealPromotionsPage()`

#### **`lib/pages/home/components/top_banner.dart` (DiscountBanner)**
- Replaced static SVG with `RealPromotionsBanner()`
- Now displays real backend promotions automatically

---

## Backend API Contract

**Endpoint:** `GET http://192.168.1.59:8000/buyandsellDjango-apis/promotion-flyers`

**Response Format:**
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

**Key Points:**
- All items have `type: "promotion"` (normalized in backend)
- `image_url` is absolute URL (can be accessed from any machine)
- `splashscreen=true` → shows on app startup
- `home=true` → shows in home page carousel
- `expire_date` filtering is automatic (only active promotions returned)
- Items sorted by expiry date (soonest first)

---

## How It Works

### 1. **App Startup Flow**

```
App Launch
    ↓
HomePage loads
    ↓
DiscountBanner (RealPromotionsBanner) mounts
    ↓
Calls PromotionFlyerService.fetchHomePageFlyers()
    ↓
HTTP GET to backend API
    ↓
Parse JSON → PromotionFlyer objects
    ↓
Filter (home=true, not expired, sorted by expiry)
    ↓
Display in carousel with auto-rotation
```

### 2. **Promotions Tab Flow**

```
User taps "Promotions" tab
    ↓
RealPromotionsPage mounts
    ↓
Calls PromotionFlyerService.fetchPromotionFlyers()
    ↓
API request → JSON parsing → PromotionFlyer objects
    ↓
Display in list/grid view
    ↓
User can pull-to-refresh to reload
```

### 3. **Details View Flow**

```
User taps promotion (from carousel or list)
    ↓
Dialog opens
    ↓
Shows full image, title, owner, expiry info
    ↓
User can tap "Visit Link" → Opens promotion URL
    ↓
User can close dialog
```

---

## Caching Strategy

- **Duration:** 5 minutes
- **Auto-refresh:** Each API call checks cache age
- **Manual clear:** `PromotionFlyerService.clearCache()` in pull-to-refresh
- **Benefits:** Reduces server load, faster UI response

---

## Error Handling

The app gracefully handles:
- ✅ Network timeouts (10-second timeout)
- ✅ HTTP errors (non-200 status codes)
- ✅ Invalid JSON parsing
- ✅ Missing image URLs (shows placeholder icon)
- ✅ No promotions available (shows empty state)

Users can manually retry via:
- Pull-to-refresh button
- Retry button in error screen

---

## Configuration

**Backend URL:**
Located in `lib/service/promotion_flyer_service.dart`:

```dart
static const String backendBaseUrl = 'http://192.168.1.59:8000';
```

To change:
1. Update `backendBaseUrl` constant
2. Rebuild app
3. OR make it configurable via settings screen

---

## Development Notes

### Testing with Mock Backend

If backend is down, temporarily add mock data to the service:

```dart
// In PromotionFlyerService.fetchPromotionFlyers()
if (response.statusCode == 200) {
  // Mock response for testing
  final mockJson = [
    {
      'id': 1,
      'type': 'promotion',
      'title': 'Test Promotion',
      // ... etc
    }
  ];
  final flyers = mockJson.map(...).toList();
  return flyers;
}
```

### Debugging

Enable logging by adding debug prints in:
- `lib/service/promotion_flyer_service.dart` - API calls
- `lib/pages/home/promotions_real.dart` - UI state

Example:
```dart
debugPrint('Fetching promotions from: ${PromotionFlyerService.getFullApiUrl()}');
debugPrint('Received ${flyers.length} active promotions');
```

### Performance Optimization

For large numbers of promotions:
- Implement pagination in backend
- Add pagination request params to service
- Use `ListView.builder()` for infinite scroll

---

## User Experience Flow

### Scenario 1: First App Launch
1. App loads, home page shows
2. DiscountBanner appears with loading spinner (1-2 seconds)
3. First promotion appears automatically
4. Carousel rotates every 4 seconds
5. User sees: "Maraka promotion" → real image → "Expires in 7 days"

### Scenario 2: User Opens Promotions Tab
1. Page loads with loading spinner
2. Shows grid of 2-4 active promotions
3. User sees: Image thumbnail + Title + "7d left"
4. User taps → Dialog opens with full image
5. User taps "Visit Link" → Opens URL in browser
6. User taps "X" → Dialog closes

### Scenario 3: Admin Updates Promotions
1. Admin adds/updates/expires promotions in Django admin
2. Changes live immediately in backend
3. App's 5-minute cache expires
4. Next user request gets fresh data
5. OR user manually pull-to-refresh for instant update

---

## Required Dependencies

Already included in `pubspec.yaml`:
- `http: ^1.2.0` - HTTP client
- `cached_network_image: ^3.3.1` - Image caching/loading
- `carousel_slider: ^5.1.2` - Carousel widget
- `url_launcher: ^6.2.6` - Open URLs
- `get: ^4.6.6` - State management

No additional packages needed.

---

## Troubleshooting

### Images not loading?
- Check backend image URL format: must be `http://192.168.1.59:8000/uploads/...`
- Verify media files exist in Django `/uploads/` directory
- Check network connectivity between device and backend

### No promotions showing?
- Verify backend is running: `GET http://192.168.1.59:8000/buyandsellDjango-apis/promotion-flyers`
- Check admin dashboard: Ensure banners have `home=true`
- Check expiry dates: Promotions must not be expired
- Clear app cache: `PromotionFlyerService.clearCache()`

### Carousel not auto-rotating?
- Only rotates if 2+ promotions available
- Check carousel options in `_PromotionCarousel.build()`
- Verify promotions have 4-second auto-play interval set

### App crashes when loading promotions?
- Check JSON parsing in `PromotionFlyer.fromJson()`
- Verify all required fields present in backend response
- Check Flutter console for parsing errors

---

## Next Steps (Optional Enhancements)

- [ ] Add analytics tracking (which promotions users view)
- [ ] Add sharing feature ("Share promotion with friends")
- [ ] Add favorites/bookmarking
- [ ] Add notification when new promotion added
- [ ] Implement pagination for very large promotion lists
- [ ] Add custom configuration for auto-play interval
- [ ] Add promotion categories/filtering
- [ ] Sync promotion views with Django analytics
