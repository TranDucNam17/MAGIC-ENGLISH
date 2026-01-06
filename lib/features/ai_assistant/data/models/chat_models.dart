// Chat message model
class ChatMessage {
  final String id;
  final String content;
  final MessageRole role; // 'user' or 'assistant'
  final DateTime timestamp;
  final bool isLoading;
  final bool isWelcome;

  ChatMessage({
    required this.id,
    required this.content,
    required this.role,
    required this.timestamp,
    this.isLoading = false,
    this.isWelcome = false,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      role: json['role'] == 'user' ? MessageRole.user : MessageRole.assistant,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      isLoading: json['isLoading'] ?? false,
      isWelcome: json['isWelcome'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'role': role == MessageRole.user ? 'user' : 'assistant',
      'timestamp': timestamp.toIso8601String(),
      'isLoading': isLoading,
      'isWelcome': isWelcome,
    };
  }
}

enum MessageRole { user, assistant }

// Gemini API request/response models
class GeminiRequest {
  final List<Content> contents;
  final List<SafetySetting>? safetySettings;
  final GenerationConfig? generationConfig;

  GeminiRequest({
    required this.contents,
    this.safetySettings,
    this.generationConfig,
  });

  Map<String, dynamic> toJson() {
    return {
      'contents': contents.map((c) => c.toJson()).toList(),
      'safetySettings': safetySettings?.map((s) => s.toJson()).toList(),
      'generationConfig': generationConfig?.toJson(),
    };
  }
}

class Content {
  final String role; // 'user' or 'model'
  final List<Part> parts;

  Content({required this.role, required this.parts});

  Map<String, dynamic> toJson() {
    return {'role': role, 'parts': parts.map((p) => p.toJson()).toList()};
  }
}

class Part {
  final String text;

  Part({required this.text});

  Map<String, dynamic> toJson() {
    return {'text': text};
  }
}

class GenerationConfig {
  final double temperature;
  final int topK;
  final double topP;
  final int maxOutputTokens;

  GenerationConfig({
    this.temperature = 0.7,
    this.topK = 40,
    this.topP = 0.95,
    this.maxOutputTokens = 2048,
  });

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'topK': topK,
      'topP': topP,
      'maxOutputTokens': maxOutputTokens,
    };
  }
}

class SafetySetting {
  final String category;
  final String threshold;

  SafetySetting({required this.category, required this.threshold});

  Map<String, dynamic> toJson() {
    return {'category': category, 'threshold': threshold};
  }
}

class GeminiResponse {
  final List<Candidate> candidates;

  GeminiResponse({required this.candidates});

  factory GeminiResponse.fromJson(Map<String, dynamic> json) {
    var candidates =
        (json['candidates'] as List?)
            ?.map((c) => Candidate.fromJson(c))
            .toList() ??
        [];
    return GeminiResponse(candidates: candidates);
  }

  String? getFirstText() {
    if (candidates.isEmpty) return null;
    var parts = candidates.first.content.parts;
    if (parts.isEmpty) return null;
    return parts.first.text;
  }
}

class Candidate {
  final Content content;
  final String finishReason;

  Candidate({required this.content, required this.finishReason});

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      content: Content(
        role: json['content']['role'] ?? 'model',
        parts:
            (json['content']['parts'] as List?)
                ?.map((p) => Part(text: p['text'] ?? ''))
                .toList() ??
            [],
      ),
      finishReason: json['finishReason'] ?? 'STOP',
    );
  }
}

// Chat session model
class ChatSession {
  final String id;
  final String title;
  final List<ChatMessage> messages;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatSession({
    required this.id,
    required this.title,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Chat',
      messages:
          (json['messages'] as List?)
              ?.map((m) => ChatMessage.fromJson(m))
              .toList() ??
          [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'messages': messages.map((m) => m.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
