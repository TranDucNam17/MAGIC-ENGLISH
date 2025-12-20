import 'package:flutter/material.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

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
          'Achievements',
          style: TextStyle(
              color: darkText, fontWeight: FontWeight.bold, fontSize: 18),
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
                const _SummaryCard(),
                const SizedBox(height: 24),
                _buildBadgeSection("Vocabulary"),
                const SizedBox(height: 24),
                _buildBadgeSection("Write"),
                const SizedBox(height: 24),
                _buildBadgeSection("Grammar"),
              ],
            ),
          ),
        ),
      ),
      // BottomNavigationBar
    );
  }

  Widget _buildBadgeSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A252F),
          ),
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(
              child: _BadgeCard(
                imagePath: "assets/images/gold_badge.png",
                label: "Gold Badge",
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _BadgeCard(
                imagePath: "assets/images/silver_badge.png",
                label: "Silver Badge",
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _BadgeCard(
                imagePath: "assets/images/bronze_badge.png",
                label: "Bronze Badge",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Achievements",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF0D47A1)),
          ),
          const SizedBox(height: 8),
          Text(
            "You've unlocked 8 badges! Keep learning to earn more",
            style: TextStyle(color: Colors.grey[800], height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final String imagePath;
  final String label;

  const _BadgeCard({
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120, // Chiều cao cố định
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 50,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.emoji_events,
                  size: 50, color: Colors.amber);
            },
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

