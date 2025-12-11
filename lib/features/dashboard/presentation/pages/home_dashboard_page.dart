// lib/features/dashboard/presentation/pages/home_dashboard_page.dart

// Import tất cả các trang của bạn (giữ nguyên)
import 'package:btl_magicenglish/features/dashboard/presentation/pages/achievements_page.dart';
import 'package:btl_magicenglish/features/dashboard/presentation/pages/ai_assistant_page.dart';
import 'package:btl_magicenglish/features/dashboard/presentation/pages/cefr_level_page.dart';
import 'package:btl_magicenglish/features/dashboard/presentation/pages/grammar_checker_page.dart';
import 'package:btl_magicenglish/features/dashboard/presentation/pages/magic_vocab_page.dart';
import 'package:btl_magicenglish/features/dashboard/presentation/pages/notifications_page.dart';
import 'package:btl_magicenglish/features/dashboard/presentation/pages/part_of_speech_page.dart';
import 'package:btl_magicenglish/features/dashboard/presentation/pages/profile_page.dart';
import 'package:btl_magicenglish/features/dashboard/presentation/pages/progress_tracking_page.dart';
import 'package:btl_magicenglish/features/dashboard/presentation/pages/word_learned_page.dart';
import 'package:flutter/material.dart';

// --- MÀN HÌNH CHÍNH (HOME DASHBOARD SCREEN) ---
class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int _selectedIndex = 0;

  // Danh sách các trang tương ứng với các tab
  // _HomeScreenContent đã được định nghĩa ở dưới
  static const List<Widget> _widgetOptions = <Widget>[
    _HomeScreenContent(),       // Index 0: Trang Home
    MagicVocabScreen(),         // Index 1: Trang Vocab
    GrammarCheckerScreen(),     // Index 2: Trang Grammar
    ProfilePage(),              // Index 3: Trang Profile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color lightBlueBackground = Color(0xFFF7F9FC);

    return Scaffold(
      backgroundColor: lightBlueBackground,

      // =================================================================
      // SỬA LỖI CHÍNH: body bây giờ sẽ hiển thị widget tương ứng với tab được chọn
      // =================================================================
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      // Hoặc cách khác:
      // body: _widgetOptions.elementAt(_selectedIndex),

      // Bottom Navigation Bar (Giữ nguyên)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryBlue,
        unselectedItemColor: Colors.grey[600],
        selectedFontSize: 12,
        unselectedFontSize: 12,
        backgroundColor: Colors.white,
        elevation: 8.0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: 'Vocab'),
          BottomNavigationBarItem(icon: Icon(Icons.spellcheck_outlined), label: 'Grammar'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}


// =================================================================
// CÁC WIDGET BÊN DƯỚI GIỮ NGUYÊN, KHÔNG CẦN THAY ĐỔI GÌ
// =================================================================


// MỚI: Tách toàn bộ nội dung của màn hình Home ra một Widget riêng
// Điều này giúp cấu trúc code sạch sẽ và logic điều hướng chính xác
class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Header Greeting Card
              const HeaderGreetingCard(userName: "Nam"),
              const SizedBox(height: 16),

              // 2. Daily Streak Section
              const DailyStreakCard(streakDays: 12),
              const SizedBox(height: 16),

              // 3. Stats Grid (4 stats)
              const StatsGrid(),
              const SizedBox(height: 16),

              // 4. Continue Learning Card
              const ContinueLearningCard(),
              const SizedBox(height: 24),

              // 5. Feature Shortcuts Row
              const FeatureShortcuts(),
              const SizedBox(height: 24),

              // 6. CEFR Progress Card
              const CefrProgressCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}


// --- CÁC WIDGET THÀNH PHẦN (Giữ nguyên không thay đổi) ---

// 1. Header Greeting Card
class HeaderGreetingCard extends StatelessWidget {
  final String userName;
  const HeaderGreetingCard({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFF0D47A1).withOpacity(0.2),
              child: Text(
                userName.isNotEmpty ? userName[0] : 'U',
                style: const TextStyle(
                  color: Color(0xFF0D47A1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good morning, $userName",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A252F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Let's grow today",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Colors.grey),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 2. Daily Streak Card
class DailyStreakCard extends StatelessWidget {
  final int streakDays;
  const DailyStreakCard({super.key, required this.streakDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.local_fire_department_rounded, color: Colors.orangeAccent),
              const SizedBox(width: 8),
              Text(
                "Daily Streak: $streakDays days",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              const Text(
                "View details",
                style: TextStyle(color: Color(0xFF0D47A1), fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.7, // Giả sử tiến độ streak
            backgroundColor: Colors.grey[300],
            color: Colors.orangeAccent,
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}

// 3. Stats Grid
class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const WordLearnedScreen()));
          },
          child: const _StatTile(
            icon: Icons.translate,
            title: "Word Learned",
            value: "120",
            color: Colors.blue,
          ),
        ),

        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CefrLevelScreen()));
          },
          child: const _StatTile(
            icon: Icons.trending_up,
            title: "CEFR Level",
            value: "A1 → B1",
            color: Colors.purple,
          ),
        ),

        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PartOfSpeechScreen()));
          },
          child: const _StatTile(
            icon: Icons.category,
            title: "Parts of Speech",
            value: "8 Types",
            color: Colors.green,
          ),
        ),

        const _StatTile(
          icon: Icons.timer,
          title: "Study Time Today",
          value: "18 min",
          color: Colors.redAccent,
        ),
      ],
    );
  }
}

// Widget con cho mỗi ô trong Stats Grid
class _StatTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A252F),
            ),
          ),
        ],
      ),
    );
  }
}

// 4. Continue Learning Card
class ContinueLearningCard extends StatelessWidget {
  const ContinueLearningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D47A1).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.book, color: Color(0xFF0D47A1)),
              SizedBox(width: 8),
              Text(
                "Continue Learning",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "Serendipity",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "Finding something good without looking for it.",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Lesson Progress", style: TextStyle(fontSize: 12)),
              Text("67%", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.67,
            backgroundColor: Colors.grey[300],
            color: const Color(0xFF0D47A1),
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: const Text("Resume Lesson", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

// 5. Feature Shortcuts
class FeatureShortcuts extends StatelessWidget {
  const FeatureShortcuts({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MagicVocabScreen())
            );
          },
          child: const _ShortcutItem(icon: Icons.school, label: "Magic Vocab"),
        ),

        GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GrammarCheckerScreen())
            );
          },
          child: const _ShortcutItem(icon: Icons.rule, label: "Grammar"),
        ),

        GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AiAssistantScreen())
            );
          },
          child: const _ShortcutItem(icon: Icons.auto_awesome, label: "AI Assistant"),
        ),

        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProgressTrackingPage())
            );
          },
          child: const _ShortcutItem(icon: Icons.bar_chart, label: "Progress"),
        ),

        GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AchievementsPage())
            );
          },
          child: const _ShortcutItem(icon: Icons.emoji_events, label: "Achievements"),
        ),
      ],
    );
  }
}

// Widget con cho mỗi shortcut
class _ShortcutItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ShortcutItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF0D47A1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF0D47A1), size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// 6. CEFR Progress Card
class CefrProgressCard extends StatelessWidget {
  const CefrProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "CEFR Progress",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            _CefrLevelRow(level: "A1", progress: 1.0), // Đã hoàn thành
            _CefrLevelRow(level: "A2", progress: 0.75),
            _CefrLevelRow(level: "B1", progress: 0.3),
            _CefrLevelRow(level: "B2", progress: 0.0),
            _CefrLevelRow(level: "C1", progress: 0.0),
            _CefrLevelRow(level: "C2", progress: 0.0),
          ],
        ),
      ),
    );
  }
}

// Widget con cho mỗi hàng trong CEFR Progress
class _CefrLevelRow extends StatelessWidget {
  final String level;
  final double progress;
  const _CefrLevelRow({required this.level, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 35,
            child: Text(
              level,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: const Color(0xFF0D47A1),
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}

