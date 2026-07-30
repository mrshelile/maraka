import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:maraka/models/promotion_flyer.dart';

/// Service for fetching promotion flyers from the Django backend
/// Backend URL: http://192.168.1.59:8000/buyandsellDjango-apis/promotion-flyers
class PromotionFlyerService {
  // Backend API base URL - can be configured via environment or settings
  static const String backendBaseUrl = 'http://192.168.1.59:8000';
  static const String promotionEndpoint =
      '/buyandsellDjango-apis/promotion-flyers';

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
      final url = Uri.parse('$backendBaseUrl$promotionEndpoint');
      final response = await http
          .get(url)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timeout: Backend took too long to respond',
              );
            },
          );

      if (response.statusCode == 200) {
        // Parse JSON response
        final List<dynamic> jsonData = jsonDecode(response.body);

        // Convert to PromotionFlyer objects and filter active ones
        final flyers = jsonData
            .map(
              (item) => PromotionFlyer.fromJson(item as Map<String, dynamic>),
            )
            .where((flyer) => flyer.isActive) // Only active promotions
            .toList();

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
      throw Exception('Error fetching promotions: $e');
    }
  }

  /// Fetch promotion flyers for splash screen (splashscreen == true)
  static Future<List<PromotionFlyer>> fetchSplashScreenFlyers() async {
    final flyers = await fetchPromotionFlyers();
    return flyers.where((flyer) => flyer.splashscreen).toList();
  }

  /// Fetch promotion flyers for home page (home == true)
  static Future<List<PromotionFlyer>> fetchHomePageFlyers() async {
    final flyers = await fetchPromotionFlyers();
    return flyers.where((flyer) => flyer.home).toList();
  }

  /// Fetch flyers for a specific owner
  static Future<List<PromotionFlyer>> fetchFlyersByOwner(String owner) async {
    final flyers = await fetchPromotionFlyers();
    return flyers
        .where((flyer) => flyer.owner.toLowerCase() == owner.toLowerCase())
        .toList();
  }

  /// Clear the cache to force refresh on next fetch
  static void clearCache() {
    _cachedFlyers = null;
    _cacheTime = null;
  }

  /// Update backend base URL (useful for switching between dev/prod)
  static String getBackendBaseUrl() => backendBaseUrl;

  /// Get full API endpoint URL
  static String getFullApiUrl() => '$backendBaseUrl$promotionEndpoint';
}
