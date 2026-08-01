import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:maraka/logic/constants.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/service/promotion_flyer_service.dart';

class PromotionManagementService {
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

    final response = await http.Response.fromStream(await request.send());
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
  }) async {
    final imageId = await _uploadImage(image);
    final response = await http.post(
      Uri.parse('$server/banners-create'),
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
    );

    if (response.statusCode != 201) {
      throw Exception('Promotion creation failed: ${response.statusCode}');
    }
    PromotionFlyerService.clearCache();
  }
}
