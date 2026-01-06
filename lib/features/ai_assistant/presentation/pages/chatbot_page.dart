import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/chat_models.dart';
import '../../data/services/chat_api_service.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  List<String> _suggestions = [];
  bool _isLoading = false;
  bool _suggestionsLoaded = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    _messages.insert(
      0,
      ChatMessage(
        id: const Uuid().v4(),
        content:
            'Xin chào! 👋 Tôi là Trợ lý Học Tiếng Anh AI của bạn. Tôi có thể giúp bạn với:\n\n📚 Học từ vựng mới\n✍️ Sửa lỗi chính tả\n🎓 Giải thích quy tắc ngữ pháp\n💡 Cung cấp các mẹo ngôn ngữ\n\nBạn cần giúp gì?',
        role: MessageRole.assistant,
        timestamp: DateTime.now(),
        isWelcome: true,
      ),
    );
  }

  Future<void> _loadSuggestions() async {
    try {
      final suggestions = await ChatApiService.getSuggestions();
      if (mounted) {
        setState(() {
          _suggestions = suggestions;
          _suggestionsLoaded = true;
        });
      }
    } catch (e) {
      print('Lỗi tải gợi ý: $e');
      // Nếu có lỗi, sử dụng các gợi ý mặc định
      if (mounted) {
        setState(() {
          _suggestions = [
            '📚 Giúp tôi học từ vựng mới',
            '✍️ Sửa lỗi chính tả tiếng Anh của tôi',
            '🎓 Giải thích một quy tắc ngữ pháp',
            '💡 Cho tôi các mẹo về từ vựng',
            '🔤 Dịch một cụm từ',
            '🎯 Đề xuất mục tiêu học tập',
          ];
          _suggestionsLoaded = true;
        });
      }
    }
  }

  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    final userMessage = ChatMessage(
      id: const Uuid().v4(),
      content: message.trim(),
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.insert(0, userMessage);
      _messageController.clear();
      _isLoading = true;
      _errorMessage = null;
    });

    _scrollToBottom();

    try {
      // Thêm loading indicator
      final loadingMessage = ChatMessage(
        id: const Uuid().v4(),
        content: '',
        role: MessageRole.assistant,
        timestamp: DateTime.now(),
        isLoading: true,
      );

      setState(() {
        _messages.insert(0, loadingMessage);
      });

      // Gửi message tới AI
      // Filter bỏ welcome message và loading messages khỏi history
      final historyForApi = _messages
          .skip(1) // Bỏ loading message
          .where((msg) => !msg.isWelcome && !msg.isLoading)
          .toList();

      final response = await ChatApiService.sendMessage(
        message,
        history: historyForApi,
      );

      // Xóa loading message và thêm response
      if (mounted) {
        setState(() {
          _messages.removeAt(0);
          final aiMessage = ChatMessage(
            id: const Uuid().v4(),
            content: response,
            role: MessageRole.assistant,
            timestamp: DateTime.now(),
          );
          _messages.insert(0, aiMessage);
          _isLoading = false;
          _errorMessage = null;
        });

        _scrollToBottom();
      }
    } catch (e) {
      print('Error: $e');
      final errorMsg = e.toString().replaceFirst('Exception: ', '');
      if (mounted) {
        setState(() {
          _messages.removeWhere((msg) => msg.isLoading);
          _isLoading = false;
          _errorMessage = errorMsg;
          final errorMessage = ChatMessage(
            id: const Uuid().v4(),
            content: '❌ Xin lỗi, tôi gặp lỗi: $errorMsg\n\nVui lòng thử lại.',
            role: MessageRole.assistant,
            timestamp: DateTime.now(),
          );
          _messages.insert(0, errorMessage);
        });

        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _clearChat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa cuộc trò chuyện?'),
        content: const Text(
          'Điều này sẽ xóa tất cả các tin nhắn trong cuộc trò chuyện này.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _messages.clear();
                _errorMessage = null;
                _addWelcomeMessage();
              });
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color lightBackground = Color(0xFFF7F9FC);

    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          '🤖 Trò chuyện với AI',
          style: TextStyle(
            color: Color(0xFF1A252F),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A252F)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Color(0xFF1A252F)),
            onPressed: _clearChat,
            tooltip: 'Xóa cuộc trò chuyện',
          ),
        ],
      ),
      body: Column(
        children: [
          // Error banner
          if (_errorMessage != null)
            Container(
              color: Colors.red.shade50,
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 16),
                    onPressed: () => setState(() => _errorMessage = null),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          // Chat messages
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Text(
                      'Không có tin nhắn nào',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return _buildMessageBubble(message);
                    },
                  ),
          ),

          // Suggestions (shown when no messages yet)
          if (_messages.length == 1 && _suggestionsLoaded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _suggestions.map((suggestion) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ElevatedButton.icon(
                        onPressed: () => _sendMessage(suggestion),
                        icon: const SizedBox.shrink(),
                        label: Text(
                          suggestion,
                          style: const TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE3F2FD),
                          foregroundColor: primaryBlue,
                          elevation: 0,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

          // Input area
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    enabled: !_isLoading,
                    decoration: InputDecoration(
                      hintText: 'Hỏi tôi bất cứ điều gì...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    maxLines: null,
                    onSubmitted: _isLoading
                        ? null
                        : (value) => _sendMessage(value),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () => _sendMessage(_messageController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.7),
                            ),
                          ),
                        )
                      : const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.role == MessageRole.user;

    if (message.isLoading) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.grey[600]!,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'AI is thinking...',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 16,
              child: const Text('🤖', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isUser ? const Color(0xFF0D47A1) : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: const Color(0xFF0D47A1),
              radius: 16,
              child: const Text('👤', style: TextStyle(fontSize: 20)),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
