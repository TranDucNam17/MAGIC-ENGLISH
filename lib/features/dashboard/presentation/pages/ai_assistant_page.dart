// lib/presentation/dashboard/ai_assistant_screen.dart

import 'package:flutter/material.dart';

// --- MÀN HÌNH CHÍNH (AI ASSISTANT SCREEN) ---
class AiAssistantScreen extends StatelessWidget {
  const AiAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
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
          'AI Assistant',
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
              // --- CÁC THÀNH PHẦN GIAO DIỆN ---
              _GreetingBox(),
              SizedBox(height: 24), // Tăng khoảng cách cho rõ ràng
              _FeatureShortcutsGrid(),
              Spacer(), // Đẩy thanh chat xuống dưới cùng
              _ChatInputBar(),
            ],
          ),
        ),
      ),
      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        // Giả sử không có tab nào được chọn vì đây là màn hình phụ
        currentIndex: 0, // Hoặc một chỉ số hợp lệ khác
        onTap: (index) { /* TODO: Handle navigation */ },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryBlue,
        unselectedItemColor: Colors.grey[600],
        selectedFontSize: 12,
        unselectedFontSize: 12,
        backgroundColor: Colors.white,
        elevation: 8.0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined), label: 'Vocab'),
          BottomNavigationBarItem(
              icon: Icon(Icons.spellcheck), label: 'Grammar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// --- CÁC WIDGET THÀNH PHẦN ---

// 1. Hộp chào mừng
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
            "Hi, Nam",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A252F),
            ),
          ),
          SizedBox(height: 4),
          Text(
            "How can I help you today?",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF4A5568),
            ),
          ),
        ],
      ),
    );
  }
}

// 2. Lưới các phím tắt tính năng
class _FeatureShortcutsGrid extends StatelessWidget {
  const _FeatureShortcutsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true, // Quan trọng khi GridView ở trong Column
      physics: const NeverScrollableScrollPhysics(), // Không cần cuộn
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.5, // Điều chỉnh tỉ lệ để nút không quá cao
      children: const [
        _FeatureButton(
          label: "Fix Grammar",
          icon: Icons.spellcheck,
          color: Color(0xFFE0F7FA), // Light Cyan
        ),
        _FeatureButton(
          label: "Improve Sentences",
          icon: Icons.auto_awesome,
          color: Color(0xFFFFF3E0), // Light Orange
        ),
        _FeatureButton(
          label: "Explain Word",
          icon: Icons.lightbulb_outline,
          color: Color(0xFFF3E5F5), // Light Purple
        ),
        _FeatureButton(
          label: "Translate EN <-> VN",
          icon: Icons.translate,
          color: Color(0xFFE8F5E9), // Light Green
        ),
        _FeatureButton(
          label: "Create Example",
          icon: Icons.add_comment_outlined,
          color: Color(0xFFFFFDE7), // Light Yellow
        ),
        _FeatureButton(
          label: "CEFR Rewrite",
          icon: Icons.school_outlined,
          color: Color(0xFFFFEBEE), // Light Red
        ),
      ],
    );
  }
}

// Widget cho một nút tính năng
class _FeatureButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _FeatureButton({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Handle feature tap
      },
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
                hintText: "Write your message...",
                border: InputBorder.none, // Bỏ viền của TextField
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

