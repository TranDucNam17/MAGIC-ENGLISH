import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../models/chat_models.dart';

class AiService {
  // Gemini API configuration
  static const String _geminiApiKey = 'YOUR_GEMINI_API_KEY'; // TODO: Set your API key
  static const String _geminiBaseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models';
  static const String _modelName = 'gemini-1.5-flash';

  // Chat context for maintaining conversation
  static final List<Content> _chatHistory = [];

  /// Initialize AI service
  static Future<void> initialize() async {
    print('🤖 Initializing AI Service...');
    _chatHistory.clear();
  }

  /// Send message to Gemini and get response
  static Future<String> sendMessage(String userMessage) async {
    try {
      print('📤 Sending message to AI: $userMessage');

      // Add user message to history
      _chatHistory.add(
        Content(
          role: 'user',
          parts: [Part(text: userMessage)],
        ),
      );

      // Build request
      final request = GeminiRequest(
        contents: _chatHistory,
        generationConfig: GenerationConfig(
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 2048,
        ),
        safetySettings: [
          SafetySetting(
            category: 'HARM_CATEGORY_SEXUALLY_EXPLICIT',
            threshold: 'BLOCK_NONE',
          ),
          SafetySetting(
            category: 'HARM_CATEGORY_HATE_SPEECH',
            threshold: 'BLOCK_NONE',
          ),
          SafetySetting(
            category: 'HARM_CATEGORY_HARASSMENT',
            threshold: 'BLOCK_NONE',
          ),
          SafetySetting(
            category: 'HARM_CATEGORY_DANGEROUS_CONTENT',
            threshold: 'BLOCK_NONE',
          ),
        ],
      );

      // Make API call
      final response = await http
          .post(
            Uri.parse(
              '$_geminiBaseUrl/$_modelName:generateContent?key=$_geminiApiKey',
            ),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(request.toJson()),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException('AI response timeout');
            },
          );

      print('📥 Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final geminiResponse =
            GeminiResponse.fromJson(jsonDecode(response.body));
        final assistantMessage = geminiResponse.getFirstText();

        if (assistantMessage == null || assistantMessage.isEmpty) {
          throw Exception('Empty response from AI');
        }

        // Add assistant message to history
        _chatHistory.add(
          Content(
            role: 'model',
            parts: [Part(text: assistantMessage)],
          ),
        );

        print('✅ AI Response: $assistantMessage');
        return assistantMessage;
      } else if (response.statusCode == 429) {
        throw Exception('Rate limit exceeded. Please try again later.');
      } else if (response.statusCode == 400) {
        final errorBody = jsonDecode(response.body);
        throw Exception(
          'Invalid request: ${errorBody['error']['message'] ?? 'Unknown error'}',
        );
      } else {
        throw Exception(
          'Failed to get AI response: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('❌ Error: $e');
      rethrow;
    }
  }

  /// Get chat context (useful for analytics/logging)
  static List<Content> getChatHistory() => List.from(_chatHistory);

  /// Clear chat history
  static void clearChatHistory() {
    _chatHistory.clear();
    print('🗑️ Chat history cleared');
  }

  /// Get last N messages
  static List<Content> getLastMessages(int count) {
    if (_chatHistory.length <= count) {
      return List.from(_chatHistory);
    }
    return _chatHistory.sublist(_chatHistory.length - count);
  }
}
