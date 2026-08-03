import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:maraka/logic/constants.dart';

class AdminPromotionService {
  /// Upload an image to the backend. Returns the created MultiImage id.
  static Future<int> uploadImage(File imageFile, String token) async {
    final uri = Uri.parse('$server/multi-image');
    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Token $token';
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    final streamed = await request.send();
    final resp = await http.Response.fromStream(streamed);
    if (resp.statusCode == 201 || resp.statusCode == 200) {
      final body = jsonDecode(resp.body);
      return body['id'] as int;
    }
    throw Exception('Image upload failed: ${resp}');
  }

  /// Create a banner (promotion)
  static Future<http.Response> createBanner({
    required String token,
    required String title,
    required String promotionType,
    required String link,
    required int displayId,
    required String expireDateIso, // e.g. 2026-12-31T23:59:59Z
    required bool splashscreen,
    required bool home,
  }) async {
    final uri = Uri.parse('$server/banners-create');
    final body = {
      'title': title,
      'promotion_type': promotionType,
      'link': link,
      'display': displayId,
      'expire_date': expireDateIso,
      'splashscreen': splashscreen,
      'home': home,
    };

    final res = await http.post(
      uri,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception('Create banner failed: \\$res');
    }
    return res;
  }
}
