/// Model for promotion flyers from the Django backend API
/// Endpoint: /buyandsellDjango-apis/promotion-flyers
class PromotionFlyer {
  final int id;
  final String type; // Always "promotion"
  final String title; // Owner name
  final String link; // URL to open when tapped
  final String imageUrl; // Absolute URL to the promotion image
  final bool splashscreen; // Show on splash/startup
  final bool home; // Show on home page
  final String owner; // Business/account owner
  final DateTime? expireDate; // When the promotion expires

  PromotionFlyer({
    required this.id,
    required this.type,
    required this.title,
    required this.link,
    required this.imageUrl,
    required this.splashscreen,
    required this.home,
    required this.owner,
    required this.expireDate,
  });

  /// Factory constructor to create PromotionFlyer from JSON
  /// Expected JSON format from backend:
  /// {
  ///   "id": 1,
  ///   "type": "promotion",
  ///   "title": "Maraka",
  ///   "link": "https://maraka.co.ls",
  ///   "image_url": "http://192.168.1.59:8000/uploads/maraka_flyer.jpg",
  ///   "splashscreen": true,
  ///   "home": true,
  ///   "owner": "Maraka",
  ///   "expire_date": "2024-01-01T00:00:00Z"
  /// }
  factory PromotionFlyer.fromJson(Map<String, dynamic> json) {
    return PromotionFlyer(
      id: json['id'] as int? ?? 0,
      type: json['type'] as String? ?? 'promotion',
      title: json['title'] as String? ?? 'Promotion',
      link: json['link'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      splashscreen: json['splashscreen'] as bool? ?? false,
      home: json['home'] as bool? ?? false,
      owner: json['owner'] as String? ?? '',
      expireDate: json['expire_date'] != null
          ? DateTime.tryParse(json['expire_date'] as String)
          : null,
    );
  }

  /// Check if promotion is still valid (not expired)
  bool get isActive {
    if (expireDate == null) return true;
    return expireDate!.isAfter(DateTime.now());
  }

  /// Get days until expiry (-1 if already expired)
  int get daysUntilExpiry {
    if (expireDate == null) return 999; // No expiry
    final difference = expireDate!.difference(DateTime.now());
    return difference.inDays;
  }

  @override
  String toString() => 'PromotionFlyer(id: $id, title: $title, link: $link)';
}
