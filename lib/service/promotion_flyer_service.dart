import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maraka/logic/constants.dart';
import 'package:maraka/models/promotion_flyer.dart';

/// Service for fetching promotion flyers from the Django backend
class PromotionFlyerService {
  static const String promotionEndpoint = '/promotion-flyers';

  static List<PromotionFlyer> parseFlyers(dynamic payload) {
    if (payload is List) {
      return payload
          .whereType<Map<String, dynamic>>()
          .map(PromotionFlyer.fromJson)
          .where((flyer) => flyer.isActive)
          .toList();
    }

    if (payload is Map<String, dynamic>) {
      final data = payload['results'];
      if (data is List) {
        return data
            .whereType<Map<String, dynamic>>()
            .map(PromotionFlyer.fromJson)
            .where((flyer) => flyer.isActive)
            .toList();
      }
    }

    if (payload is Map) {
      final data = payload['results'];
      if (data is List) {
        return data
            .whereType<Map<String, dynamic>>()
            .map(PromotionFlyer.fromJson)
            .where((flyer) => flyer.isActive)
            .toList();
      }
    }

    return <PromotionFlyer>[];
  }

  // Cache promotion flyers to avoid excessive API calls
  static List<PromotionFlyer>? _cachedFlyers;
  static DateTime? _cacheTime;
  static const Duration cacheExpiry = Duration(minutes: 5); // 5-minute cache

  /// Fetch all promotion flyers from the backend
  /// Returns list of active PromotionFlyer objects
  /// Throws an exception if the request fails
  static Future<List<PromotionFlyer>> fetchPromotionFlyers({
    bool forceRefresh = false,
  }) async {
    // Check cache first
    if (!forceRefresh && _cachedFlyers != null && _cacheTime != null) {
      if (DateTime.now().difference(_cacheTime!).compareTo(cacheExpiry) < 0) {
        return _cachedFlyers!;
      }
    }

    try {
      final url = Uri.parse('$adminContentServer$promotionEndpoint');
      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception(
            'Request timeout: Backend took too long to respond',
          );
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final flyers = parseFlyers(decoded);

        // Sort by expire date (soonest first)
        flyers.sort((a, b) {
          if (a.expireDate == null) return 1;
          if (b.expireDate == null) return -1;
          return a.expireDate!.compareTo(b.expireDate!);
        });

        // Update cache
        _cachedFlyers = flyers;
        _cacheTime = DateTime.now();

        return flyers;
      } else {
        throw Exception(
          'Failed to fetch promotions: ${response.statusCode} ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      _cachedFlyers = <PromotionFlyer>[];
      _cacheTime = DateTime.now();
      return <PromotionFlyer>[];
    }
  }

  /// Fetch promotion flyers for splash screen (splashscreen == true)
  static Future<List<PromotionFlyer>> fetchSplashScreenFlyers({
    bool forceRefresh = false,
  }) async {
    final flyers = await fetchPromotionFlyers(forceRefresh: forceRefresh);
    return flyers.where((flyer) => flyer.splashscreen).toList();
  }

  /// Fetch promotion flyers for home page (home == true)
  static Future<List<PromotionFlyer>> fetchHomePageFlyers({
    bool forceRefresh = false,
  }) async {
    final flyers = await fetchPromotionFlyers(forceRefresh: forceRefresh);
    return flyers.where((flyer) => flyer.home).toList();
  }

  /// Fetch flyers for a specific owner
  static Future<List<PromotionFlyer>> fetchFlyersByOwner(
    String owner, {
    bool forceRefresh = false,
  }) async {
    final flyers = await fetchPromotionFlyers(forceRefresh: forceRefresh);
    return flyers
        .where((flyer) => flyer.owner.toLowerCase() == owner.toLowerCase())
        .toList();
  }

  /// Clear the cache to force refresh on next fetch
  static void clearCache() {
    _cachedFlyers = null;
    _cacheTime = null;
  }

  static final StreamController<void> _promotionRefreshController =
      StreamController<void>.broadcast();

  static Stream<void> get promotionUpdates =>
      _promotionRefreshController.stream;

  static void notifyPromotionUpdated() {
    clearCache();
    if (!_promotionRefreshController.isClosed) {
      _promotionRefreshController.add(null);
    }
  }

  static void clearMockPromotions() {
    clearCache();
  }

  /// Get full API endpoint URL
  static String getFullApiUrl() => '$adminContentServer$promotionEndpoint';
}
