import 'package:btl_magicenglish/core/api/api_client.dart';
import '../models/chat_models.dart';

class ChatApiService {
  /// Send message to AI chatbot
  static Future<String> sendMessage(
    String message, {
    List<ChatMessage>? history,
  }) async {
    try {
      print('💬 Gửi tin nhắn tới chatbot: $message');

      // Chuyển history sang định dạng API
      final historyData =
          history
              ?.map(
                (msg) => {
                  'role': msg.role == MessageRole.user ? 'user' : 'assistant',
                  'content': msg.content,
                },
              )
              .toList() ??
          [];

      final payload = {'message': message, 'history': historyData};

      final response = await ApiClient.post('/ai-chat/send', body: payload);

      if (response['ok'] == true) {
        final aiMessage = response['data']['message'] ?? '';
        print('✅ Phản hồi từ AI: $aiMessage');
        return aiMessage;
      } else {
        throw Exception(
          response['error'] ?? 'Không thể nhận được phản hồi từ AI',
        );
      }
    } catch (e) {
      print('❌ Lỗi gửi tin nhắn: $e');
      rethrow;
    }
  }

  /// Get chat suggestions
  static Future<List<String>> getSuggestions() async {
    try {
      print('💡 Lấy các gợi ý trò chuyện...');

      final response = await ApiClient.get('/ai-chat/suggestions');

      if (response['ok'] == true) {
        final suggestions = List<String>.from(response['data'] ?? []);
        print('✅ Nhận được ${suggestions.length} gợi ý');
        return suggestions;
      } else {
        throw Exception('Không thể lấy gợi ý');
      }
    } catch (e) {
      print('❌ Lỗi khi lấy gợi ý: $e');
      return [
        '📚 Giúp tôi học từ vựng mới',
        '✍️ Sửa lỗi chính tả tiếng Anh của tôi',
        '🎓 Giải thích một quy tắc ngữ pháp',
        '💡 Cho tôi các mẹo về từ vựng',
        '🔤 Dịch một cụm từ',
        '🎯 Đề xuất mục tiêu học tập',
      ];
    }
  }

  /// Clear chat history on backend
  static Future<void> clearHistory() async {
    try {
      print('🗑️ Xóa lịch sử trò chuyện...');

      final response = await ApiClient.post('/ai-chat/clear', body: {});

      if (response['ok'] == true) {
        print('✅ Lịch sử trò chuyện đã được xóa');
      } else {
        throw Exception('Không thể xóa lịch sử');
      }
    } catch (e) {
      print('❌ Lỗi xóa lịch sử: $e');
      rethrow;
    }
  }
}
