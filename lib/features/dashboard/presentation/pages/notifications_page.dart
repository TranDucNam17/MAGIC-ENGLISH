// lib/presentation/dashboard/notifications_page.dart

import 'package:flutter/material.dart';

// --- MÀN HÌNH CHÍNH (NOTIFICATIONS PAGE) ---
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

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
          'Notifications',
          style: TextStyle(
              color: darkText, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        // 2. ListView chứa danh sách thông báo
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          children: const [
            // Thông báo nổi bật
            _NotificationCard(
              icon: Icons.local_fire_department,
              iconColor: Colors.orange,
              iconBackgroundColor: Color(0xFFFFF3E0),
              title: "Keep your 12-days streak!",
              message: "Don't forget to study 5 minutes today.",
              timestamp: "5 min ago",
              isHighlight: true, // Đánh dấu là thông báo nổi bật
            ),
            // Các thông báo thường
            _NotificationCard(
              icon: Icons.emoji_events,
              iconColor: Colors.amber,
              iconBackgroundColor: Color(0xFFFFFDE7),
              title: "You've unlock Bronze Vocabulary!",
              message: "You learned 50 new words.",
              timestamp: "Today, 10:12 AM",
            ),
            _NotificationCard(
              icon: Icons.article,
              iconColor: Colors.blue,
              iconBackgroundColor: Color(0xFFE3F2FD),
              title: "Review your 10 learned words",
              message: "Words: essential, structure, algorithm,…",
              timestamp: "Yesterday, 8:22 PM",
            ),
            _NotificationCard(
              icon: Icons.edit,
              iconColor: Colors.purple,
              iconBackgroundColor: Color(0xFFF3E5F5),
              title: "Your grammar check is ready",
              message: "3 errors were fixed in your last check.",
              timestamp: "Yesterday, 8:22 PM",
            ),
            _NotificationCard(
              icon: Icons.bar_chart,
              iconColor: Colors.teal,
              iconBackgroundColor: Color(0xFFE0F2F1),
              title: "CEFR Progress Updated",
              message: "You're now 63% on your journey B1.",
              timestamp: "2 days ago",
            ),
          ],
        ),
      ),
      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Tab "Home" được chọn
        onTap: (index) {
          /* TODO: Handle navigation */
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryBlue,
        unselectedItemColor: Colors.grey[600],
        selectedFontSize: 12,
        unselectedFontSize: 12,
        backgroundColor: Colors.white,
        elevation: 8.0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: 'Home'),
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

// --- WIDGET TÁI SỬ DỤNG CHO THẺ THÔNG BÁO ---
class _NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final String message;
  final String timestamp;
  final bool isHighlight;

  const _NotificationCard({
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isHighlight ? 0 : 1.5,
      shadowColor: Colors.grey.withOpacity(0.1),
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isHighlight
            ? BorderSide.none
            : BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      color: isHighlight ? const Color(0xFFEAF3FF) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon bên trái
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            // Nội dung bên phải
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF1A252F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Dấu thời gian căn phải
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      timestamp,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
