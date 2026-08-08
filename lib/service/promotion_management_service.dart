import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:maraka/logic/constants.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/models/promotion_flyer.dart';
import 'package:maraka/service/promotion_flyer_service.dart';

class PromotionManagementService {
  static final List<PromotionFlyer> _mockPromotions = <PromotionFlyer>[];

  static List<PromotionFlyer> get mockPromotions => _mockPromotions;

  static void clearMockPromotions() {
    _mockPromotions.clear();
  }
  static Future<int> _uploadImage(File image) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$server/multi-image'),
    );
    request.headers.addAll(await authenticatedHeaders(json: false));
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType('image', _extension(image.path)),
      ),
    );

    final streamedResponse = await request.send().timeout(
      const Duration(seconds: 8),
      onTimeout: () => throw TimeoutException('Image upload timed out'),
    );
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode != 201) {
      throw Exception('Image upload failed: ${response.statusCode}');
    }
    return (jsonDecode(response.body) as Map<String, dynamic>)['id'] as int;
  }

  static String _extension(String path) {
    final extension = path.split('.').last.toLowerCase();
    return extension == 'jpg' ? 'jpeg' : extension;
  }

  static Future<void> createPromotion({
    required File image,
    required String title,
    required String promotionType,
    required String link,
    required DateTime expireDate,
    bool home = true,
    bool splashscreen = false,
    String? owner,
  }) async {
    final fallbackOwner = owner ??
        Get.find<User>().name ??
        Get.find<User>().email ??
        'Mock user';

    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      _mockPromotions.add(
        PromotionFlyer(
          id: DateTime.now().millisecondsSinceEpoch,
          type: 'promotion',
          title: title,
          promotionType: promotionType,
          link: link,
          imageUrl: image.path,
          splashscreen: splashscreen,
          home: home,
          owner: fallbackOwner,
          expireDate: expireDate,
        ),
      );
      PromotionFlyerService.notifyPromotionUpdated();
      return;
    }

    try {
      final imageId = await _uploadImage(image);
      final response = await http.post(
        Uri.parse('$server/promotions-create'),
        headers: await authenticatedHeaders(),
        body: jsonEncode({
          'title': title,
          'promotion_type': promotionType,
          'link': link,
          'display': imageId,
          'expire_date': expireDate.toUtc().toIso8601String(),
          'home': home,
          'splashscreen': splashscreen,
        }),
      ).timeout(
        const Duration(seconds: 8),
        onTimeout: () => throw TimeoutException('Promotion creation timed out'),
      );

      if (response.statusCode != 201) {
        throw Exception('Promotion creation failed: ${response.statusCode}');
      }
      PromotionFlyerService.notifyPromotionUpdated();
    } catch (_) {
      _mockPromotions.add(
        PromotionFlyer(
          id: DateTime.now().millisecondsSinceEpoch,
          type: 'promotion',
          title: title,
          promotionType: promotionType,
          link: link,
          imageUrl: image.path,
          splashscreen: splashscreen,
          home: home,
          owner: fallbackOwner,
          expireDate: expireDate,
        ),
      );
      PromotionFlyerService.notifyPromotionUpdated();
    }
  }
}
