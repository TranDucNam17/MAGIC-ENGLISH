import 'package:flutter/material.dart';

// --- MÀN HÌNH CHÍNH (VIEW REWARDS SCREEN) ---
class ViewRewardsScreen extends StatefulWidget {
  const ViewRewardsScreen({super.key});

  @override
  State<ViewRewardsScreen> createState() => _ViewRewardsScreenState();
}

class _ViewRewardsScreenState extends State<ViewRewardsScreen> {
  // Giả sử tab "Home" vẫn được chọn
  final int _selectedIndex = 0;
  // Theo dõi ngày được chọn trong Day Selector
  int _selectedMilestone = 7;

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color lightBlueBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);

    return Scaffold(
      // 1. General: Nền xanh rất nhạt
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
          'View Rewards',
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
                // 1) Streak Rewards intro card
                const IntroCard(),
                const SizedBox(height: 24),

                // 2) Day selector row
                DaySelector(
                  selectedMilestone: _selectedMilestone,
                  onSelect: (day) {
                    setState(() {
                      _selectedMilestone = day;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // 3) Rewards list
                const RewardsList(),
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

// 1. Intro Card
class IntroCard extends StatelessWidget {
  const IntroCard({super.key});

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
            const Row(
              children: [
                Icon(Icons.card_giftcard, color: Color(0xFF0D47A1), size: 28),
                SizedBox(width: 12),
                Text(
                  "Streak Rewards",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A252F),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Unlock rewards by keeping your daily learning streak.",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. Day Selector
class DaySelector extends StatelessWidget {
  final int selectedMilestone;
  final Function(int) onSelect;

  const DaySelector({
    super.key,
    required this.selectedMilestone,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final milestones = [7, 14, 21, 28, 30];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: milestones.map((day) {
          final bool isSelected = day == selectedMilestone;
          // Dữ liệu giả: giả sử ngày 7 đã hoàn thành, còn lại thì chưa
          final bool isCompleted = day == 7;

          return GestureDetector(
            onTap: () => onSelect(day),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? const Color(0xFF0D47A1) : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Day $day",
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? const Color(0xFF0D47A1) : Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    isCompleted ? Icons.check_circle : Icons.lock,
                    color: isCompleted ? const Color(0xFF0D47A1) : Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// 3. Rewards List
class RewardsList extends StatelessWidget {
  const RewardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        RewardItemCard(
          title: "Day 7: Bronze Badge",
          status: "Status: Completed",
          rewards: ["• Bronze badge", "• +20 XP", "• Celebration effect"],
          isCompleted: true,
          buttonLabel: "View details",
          badgeIcon: Icons.shield,
          badgeColor: Color(0xFFCD7F32), // Bronze color
        ),
        SizedBox(height: 16),
        RewardItemCard(
          title: "Day 14: Silver Badge",
          status: "Status: Available in 2 days",
          rewards: ["• Silver badge", "• +50 XP", "• Confetti 1 effect"],
          isCompleted: false,
          buttonLabel: "Keep learning",
          badgeIcon: Icons.shield,
          badgeColor: Color(0xFFC0C0C0), // Silver color
        ),
        SizedBox(height: 16),
        RewardItemCard(
          title: "Day 21: Gold Badge",
          status: "Status: Available in 9 days",
          rewards: ["• Gold badge", "• +100 XP", "• Fireworks effect"],
          isCompleted: false,
          buttonLabel: "Keep learning",
          badgeIcon: Icons.shield,
          badgeColor: Color(0xFFFFD700), // Gold color
        ),
      ],
    );
  }
}

// Widget con cho mỗi thẻ Reward
class RewardItemCard extends StatelessWidget {
  final String title;
  final String status;
  final List<String> rewards;
  final bool isCompleted;
  final String buttonLabel;
  final IconData badgeIcon;
  final Color badgeColor;

  const RewardItemCard({
    super.key,
    required this.title,
    required this.status,
    required this.rewards,
    required this.isCompleted,
    required this.buttonLabel,
    required this.badgeIcon,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Badge Icon
            Icon(badgeIcon, color: badgeColor, size: 40),
            const SizedBox(width: 16),
            // Middle: Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Rewards:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  ...rewards.map((reward) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      reward,
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Right: Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              child: Text(buttonLabel),
            )
          ],
        ),
      ),
    );
  }
}
