import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/config/app_config.dart';

class GrammarApiService {
  static const String _baseUrl = '${AppConfig.apiBaseUrl}/grammar-check';

  /// Check grammar for a given text
  /// Returns a map with: level, errors_count, errors[], corrected_text
  static Future<Map<String, dynamic>> checkGrammar(String text) async {
    try {
      print('🔍 Grammar Check Request:');
      print('  Text: $text');

      final response = await http
          .post(
            Uri.parse('$_baseUrl'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: json.encode({
              'text': text,
              'user_id': 1, // TODO: Get from auth context
            }),
          )
          .timeout(
            const Duration(seconds: 60),
            onTimeout: () =>
                throw Exception('Request timeout after 60 seconds'),
          );

      print('Grammar Check Response:');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Handle different response structures
        Map<String, dynamic> result = {};

        // Check for both 'success' and 'ok' fields
        bool isSuccess =
            responseData['success'] == true || responseData['ok'] == true;

        if (isSuccess) {
          // Extract data from different possible structures
          if (responseData['data'] != null) {
            if (responseData['data'] is Map) {
              result = responseData['data'];
            } else if (responseData['data'] is List) {
              result = {'result': responseData['data']};
            }
          } else {
            result = responseData;
          }
        }

        return _normalizeResponse(result);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      } else {
        throw Exception(
          'Grammar check failed: ${response.statusCode} ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      print('❌ Grammar Check Error: $e');
      rethrow;
    }
  }

  /// Get AI tips and examples for a specific grammar topic
  static Future<List<Map<String, dynamic>>> getTipsAndExamples(
    String topic,
  ) async {
    try {
      print('💡 Fetching Tips for topic: $topic');

      final response = await http
          .get(
            Uri.parse('$_baseUrl/tips?topic=$topic'),
            headers: {'Accept': 'application/json'},
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () =>
                throw Exception('Request timeout after 30 seconds'),
          );

      print('📤 Tips Response:');
      print('  Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        List<Map<String, dynamic>> tips = [];
        if (responseData['success'] == true && responseData['data'] != null) {
          tips = List<Map<String, dynamic>>.from(responseData['data']);
        }

        return tips;
      } else {
        throw Exception('Failed to fetch tips: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Tips Fetch Error: $e');
      rethrow;
    }
  }

  /// Get grammar check history for current user
  static Future<List<Map<String, dynamic>>> getHistory({
    int page = 1,
    int limit = 10,
    String? filterBy, // 'all', 'errors', 'success'
  }) async {
    try {
      print('📋 Fetching Grammar History:');
      print('  Page: $page, Limit: $limit');

      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        if (filterBy != null) 'filter': filterBy,
      };

      final uri = Uri.parse(
        '$_baseUrl/history',
      ).replace(queryParameters: queryParams);

      final response = await http
          .get(uri, headers: {'Accept': 'application/json'})
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () =>
                throw Exception('Request timeout after 30 seconds'),
          );

      print('📤 History Response:');
      print('  Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        List<Map<String, dynamic>> history = [];
        if (responseData['ok'] == true || responseData['success'] == true) {
          final data = responseData['data'];

          // Handle paginated response format
          if (data is Map && data['items'] != null) {
            // Extract items from pagination response
            final items = data['items'];
            if (items is List) {
              history = List<Map<String, dynamic>>.from(
                items.map((item) {
                  if (item is Map<String, dynamic>) {
                    // Parse errors JSON if it's a string
                    if (item['errors'] is String) {
                      try {
                        item['errors'] = json.decode(item['errors']);
                      } catch (e) {
                        item['errors'] = [];
                      }
                    }
                    return item;
                  }
                  return {};
                }),
              );
            }
          } else if (data is List) {
            // Handle direct list response
            history = List<Map<String, dynamic>>.from(data);
          }
        }

        return history;
      } else {
        throw Exception('Failed to fetch history: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ History Fetch Error: $e');
      rethrow;
    }
  }

  /// Delete a grammar check record
  static Future<bool> deleteCheckRecord(int recordId) async {
    try {
      print('🗑️ Deleting Grammar Check Record: $recordId');

      final response = await http
          .delete(
            Uri.parse('$_baseUrl/$recordId'),
            headers: {'Accept': 'application/json'},
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () =>
                throw Exception('Request timeout after 30 seconds'),
          );

      print('📤 Delete Response:');
      print('  Status: ${response.statusCode}');

      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print('❌ Delete Error: $e');
      rethrow;
    }
  }

  /// Normalize API response to standard format
  static Map<String, dynamic> _normalizeResponse(Map<String, dynamic> data) {
    // Đảm bảo errors luôn là list
    List<dynamic> errorsList = [];
    if (data['errors'] != null) {
      if (data['errors'] is List) {
        errorsList = data['errors'] as List<dynamic>;
      }
    }

    return {
      'level': data['level'] ?? 'B1',
      'errors_count': data['errors_count'] ?? errorsList.length ?? 0,
      'errors': errorsList,
      'corrected_text': data['corrected_text'] ?? '',
      'explanation': data['explanation'] ?? '',
      'score': data['score'] ?? 0.0,
    };
  }
}
