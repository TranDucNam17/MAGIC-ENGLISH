import 'package:flutter/material.dart';
import 'chatbot_page.dart';

class AiAssistantScreen extends StatelessWidget {
  const AiAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color lightBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);

    return Scaffold(
      backgroundColor: lightBackground,
      // 1. AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.grey.withOpacity(0.2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Trợ lý AI',
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GreetingBox(),
              SizedBox(height: 24),
              _FeatureShortcutsGrid(),
              Spacer(),
              _ChatInputBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _GreetingBox extends StatelessWidget {
  const _GreetingBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Xin chào, Nam",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A252F),
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Tôi có thể giúp bạn với gì hôm nay?",
            style: TextStyle(fontSize: 14, color: Color(0xFF4A5568)),
          ),
        ],
      ),
    );
  }
}

class _FeatureShortcutsGrid extends StatelessWidget {
  const _FeatureShortcutsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.5,
      children: [
        const _FeatureButton(
          label: "Sửa ngữ pháp",
          icon: Icons.spellcheck,
          color: Color(0xFFE0F7FA), // Light Cyan
        ),
        const _FeatureButton(
          label: "Cải thiện câu",
          icon: Icons.auto_awesome,
          color: Color(0xFFFFF3E0), // Light Orange
        ),
        const _FeatureButton(
          label: "Giải thích từ",
          icon: Icons.lightbulb_outline,
          color: Color(0xFFF3E5F5), // Light Purple
        ),
        const _FeatureButton(
          label: "Dịch EN <-> VN",
          icon: Icons.translate,
          color: Color(0xFFE8F5E9), // Light Green
        ),
        const _FeatureButton(
          label: "Tạo ví dụ",
          icon: Icons.add_comment_outlined,
          color: Color(0xFFFFFDE7), // Light Yellow
        ),
        _FeatureButton(
          label: "Trò chuyện với AI 🤖",
          icon: Icons.chat_bubble_outline,
          color: const Color(0xFFFFEBEE), // Light Red
          onTap: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const ChatbotPage())),
        ),
      ],
    );
  }
}

class _FeatureButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _FeatureButton({
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.black87, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. Thanh nhập liệu chat
class _ChatInputBar extends StatelessWidget {
  const _ChatInputBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24), // Bo tròn thanh input
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.mic_none),
            onPressed: () {},
            color: Colors.grey[600],
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Viết tin nhắn của bạn...",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {},
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
