import 'package:flutter/material.dart';

// --- MÀN HÌNH CHÍNH (DAILY STREAK SCREEN) ---
class DailyStreakScreen extends StatefulWidget {
  const DailyStreakScreen({super.key});

  @override
  State<DailyStreakScreen> createState() => _DailyStreakScreenState();
}

class _DailyStreakScreenState extends State<DailyStreakScreen> {
  // Giả sử tab "Home" vẫn được chọn khi vào màn hình này từ Home.
  // Nếu màn hình này là một tab riêng, bạn cần thay đổi logic này.
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color lightBlueBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);

    return Scaffold(
      // 1. Layout: Nền xanh rất nhạt
      backgroundColor: lightBlueBackground,
      // 2. AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.grey.withOpacity(0.2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Daily Streak',
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1) Streak highlight card
                const StreakHighlightCard(streakDays: 12),
                const SizedBox(height: 24),

                // 2) Today's Progress section
                const TodayProgressSection(progress: 0.67),
                const SizedBox(height: 24),

                // 3) This Week section
                const ThisWeekSection(),
                const SizedBox(height: 24),

                // 4) Rewards card
                const RewardsCard(),
                const SizedBox(height: 16),

                // 5) Daily Reminder card
                const DailyReminderCard(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      // 3. BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          // TODO: Xử lý điều hướng khi nhấn vào các tab khác
        },
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
              icon: Icon(Icons.spellcheck_outlined), label: 'Grammar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// --- CÁC WIDGET THÀNH PHẦN ---

// 1. Streak Highlight Card
class StreakHighlightCard extends StatelessWidget {
  final int streakDays;
  const StreakHighlightCard({super.key, required this.streakDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_fire_department_rounded,
              color: Colors.orangeAccent,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You're on a $streakDays-day streak!",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A252F),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Let's keep it going today",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 2. Today's Progress Section
class TodayProgressSection extends StatelessWidget {
  final double progress;
  const TodayProgressSection({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today’s Progress",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A252F),
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "${(progress * 100).toInt()}%",
            style: const TextStyle(
              color: primaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 12,
            backgroundColor: Colors.blue.withOpacity(0.15),
            color: primaryBlue,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Mark today as completed",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}

// 3. This Week Section
class ThisWeekSection extends StatelessWidget {
  const ThisWeekSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu giả cho tuần
    final List<Map<String, dynamic>> weekData = [
      {"day": "Mon", "completed": true},
      {"day": "Tue", "completed": true},
      {"day": "Wed", "completed": true},
      {"day": "Thu", "completed": false, "isCurrent": true},
      {"day": "Fri", "completed": false},
      {"day": "Sat", "completed": false},
      {"day": "Sun", "completed": false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "This Week",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A252F),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekData.map((day) {
            return _DayItem(
              label: day['day'],
              isCompleted: day['completed'],
              isCurrent: day['isCurrent'] ?? false,
            );
          }).toList(),
        ),
      ],
    );
  }
}

// Widget con cho mỗi ngày trong tuần
class _DayItem extends StatelessWidget {
  final String label;
  final bool isCompleted;
  final bool isCurrent;

  const _DayItem({
    required this.label,
    required this.isCompleted,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);

    Color indicatorColor;
    Color borderColor = Colors.transparent;

    if (isCompleted) {
      indicatorColor = primaryBlue;
    } else if (isCurrent) {
      indicatorColor = primaryBlue.withOpacity(0.3);
      borderColor = primaryBlue;
    } else {
      indicatorColor = Colors.grey[300]!;
    }

    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isCurrent ? primaryBlue : Colors.grey,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: indicatorColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: isCompleted
              ? const Icon(Icons.check, color: Colors.white, size: 18)
              : null,
        ),
      ],
    );
  }
}

// 4. Rewards Card
class RewardsCard extends StatelessWidget {
  const RewardsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.card_giftcard, color: Color(0xFF0D47A1)),
                const SizedBox(width: 12),
                const Text(
                  "Rewards",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "View Rewards",
                    style: TextStyle(
                      color: Color(0xFF0D47A1),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _RewardLine(
              text: "Day 7: Completed",
              icon: Icons.check_circle,
              iconColor: Colors.green,
            ),
            _RewardLine(
              text: "Day 14: Available in 2 days",
              icon: Icons.lock_clock,
              iconColor: Colors.grey,
            ),
            _RewardLine(
              text: "Day 30: Big Rewards",
              icon: Icons.emoji_events,
              iconColor: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget con cho mỗi dòng Reward
class _RewardLine extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;

  const _RewardLine({
    required this.text,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

// 5. Daily Reminder Card
class DailyReminderCard extends StatelessWidget {
  const DailyReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.notifications_active_outlined, color: Colors.grey),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Daily Reminder",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A252F),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Never lose your streak again!",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          // Có thể thêm một Switch hoặc Icon ở đây
        ],
      ),
    );
  }
}
