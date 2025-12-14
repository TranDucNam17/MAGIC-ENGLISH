// lib/presentation/dashboard/progress_tracking_page.dart

import 'package:flutter/material.dart';

// --- MÀN HÌNH CHÍNH (PROGRESS TRACKING PAGE) ---
class ProgressTrackingPage extends StatefulWidget {
  const ProgressTrackingPage({super.key});

  @override
  State<ProgressTrackingPage> createState() => _ProgressTrackingPageState();
}

class _ProgressTrackingPageState extends State<ProgressTrackingPage> {
  // Biến trạng thái cho segmented control
  String _selectedPeriod = "Weekly";

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
          'Progress Tracking',
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
                // --- CÁC THÀNH PHẦN GIAO DIỆN ---
                const _LearningSummaryCard(),
                const SizedBox(height: 12),
                _buildPeriodControl(),
                const SizedBox(height: 12),
                const _QuickStatsCards(),
                const SizedBox(height: 12),
                const _CefrProgressCard(),
                const SizedBox(height: 12),
                const _ActivityTimelineCard(),
                const SizedBox(height: 12),
                const _RecommendedTodayCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget cho segmented control
  Widget _buildPeriodControl() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100), // Bo tròn như viên thuốc
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ["Daily", "Weekly", "Monthly"].map((period) {
          bool isSelected = _selectedPeriod == period;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPeriod = period;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFE3F2FD) // Màu xanh nhạt khi được chọn
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  period,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? const Color(0xFF0D47A1)
                        : Colors.grey[600],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// --- CÁC WIDGET THÀNH PHẦN ---

// 1. Thẻ tóm tắt học tập
class _LearningSummaryCard extends StatelessWidget {
  const _LearningSummaryCard();

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
          const Text("Your learning summary",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          _buildSummaryLine("Streak: 12 days"),
          _buildSummaryLine("Total words learned: 120"),
          _buildSummaryLine("Study time: 18 minutes today"),
          _buildSummaryLine("Current CEFR: A2 → B1"),
        ],
      ),
    );
  }

  Widget _buildSummaryLine(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(text, style: TextStyle(color: Colors.grey[800])),
    );
  }
}

// 3. Các thẻ chỉ số nhanh
class _QuickStatsCards extends StatelessWidget {
  const _QuickStatsCards();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: const [
        _StatCard(
            icon: Icons.book_outlined,
            label: "Vocabulary",
            value: "120 word"),
        _StatCard(
            icon: Icons.checklist_rtl,
            label: "Grammar",
            value: "32 checks"),
        _StatCard(
            icon: Icons.menu_book,
            label: "Reading", value: "18 lesson"),
        _StatCard(icon: Icons.edit_note,
            label: "Writing", value: "12"),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _StatCard(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.grey[600], size: 24),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

// 4. Thẻ tiến độ CEFR
class _CefrProgressCard extends StatelessWidget {
  const _CefrProgressCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.bar_chart, color: Color(0xFF0D47A1)),
                const SizedBox(width: 8),
                const Text("CEFR Progress",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            _buildCefrRow("A1", 1.0, Colors.green), // 100%
            _buildCefrRow("A2", 1.0, Colors.lightGreen), // 100%
            _buildCefrRow("B1", 0.6, Colors.blue), // 60%
            _buildCefrRow("B2", 0.1, Colors.lightBlue), // 10%
            _buildCefrRow("C1", 0.0, Colors.purple), // 0%
            _buildCefrRow("C2", 0.0, Colors.deepPurple), // 0%
          ],
        ),
      ),
    );
  }

  Widget _buildCefrRow(String level, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(level,
                style:
                TextStyle(color: color, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.grey.shade200,
              color: const Color(0xFF0D47A1),
              minHeight: 8,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      ),
    );
  }
}

// 5. Thẻ dòng thời gian hoạt động
class _ActivityTimelineCard extends StatelessWidget {
  const _ActivityTimelineCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Activity Timeline",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Icon(Icons.history, color: Colors.grey[600], size: 20),
              ],
            ),
            const SizedBox(height: 12),
            _buildTimelineItem("12/1/2025: Learned 5 new words"),
            _buildTimelineItem("13/1/2025: Grammar check"),
            _buildTimelineItem("14/1/2025: Viewing CEFR details"),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
              child: Text(text,
                  style: TextStyle(color: Colors.grey[700]))),
        ],
      ),
    );
  }
}

// 6. Thẻ gợi ý cho hôm nay
class _RecommendedTodayCard extends StatelessWidget {
  const _RecommendedTodayCard();

  @override
  Widget build(BuildContext context) {
    const Color accentTeal = Color(0xFF00695C); // Teal đậm hơn cho text

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1), // Light Mint
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recommended for Today",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: accentTeal),
          ),
          const SizedBox(height: 12),
          _buildRecommendationItem("Review 10 learned words"),
          _buildRecommendationItem("Complete 1 grammar check"),
          _buildRecommendationItem("Read 1 short article"),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
              child: Text(text,
                  style: TextStyle(color: Colors.grey[800]))),
        ],
      ),
    );
  }
}
