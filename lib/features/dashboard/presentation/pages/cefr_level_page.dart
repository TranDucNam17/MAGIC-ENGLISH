import 'package:flutter/material.dart';

// --- MÀN HÌNH CHÍNH (CEFR LEVEL SCREEN) ---
class CefrLevelScreen extends StatefulWidget {
  const CefrLevelScreen({super.key});

  @override
  State<CefrLevelScreen> createState() => _CefrLevelScreenState();
}

class _CefrLevelScreenState extends State<CefrLevelScreen> {
  // Giả sử tab "Home" vẫn được chọn
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color lightBlueBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);

    return Scaffold(
      backgroundColor: lightBlueBackground,
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
          'CEFR Level',
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
              children: const [
                // 1) CEFR summary card
                CefrSummaryCard(progress: 0.78),
                SizedBox(height: 24),

                // 2) Skills Overview grid
                SkillsOverviewGrid(),
                SizedBox(height: 24),

                // 3) Requirements to reach B1
                RequirementsSection(),
                SizedBox(height: 24),

                // 4) CEFR Roadmap card
                CefrRoadmapCard(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- CÁC WIDGET THÀNH PHẦN ---

// 1. CEFR Summary Card
class CefrSummaryCard extends StatelessWidget {
  final double progress;
  const CefrSummaryCard({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            "A1 → C2",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A252F)),
          ),
          const SizedBox(height: 4),
          const Text(
            "You’re improving steadily!",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: primaryBlue.withOpacity(0.2),
              color: primaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Progress to B1: ${(progress * 100).toInt()}%",
            style: const TextStyle(
                color: primaryBlue, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// 2. Skills Overview Grid
class SkillsOverviewGrid extends StatelessWidget {
  const SkillsOverviewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Skills Overview",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A252F)),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.2, // Điều chỉnh tỉ lệ để card không quá cao
          children: const [
            _SkillCard(skill: "Vocabulary", progress: 0.78),
            _SkillCard(skill: "Grammar", progress: 0.65),
            _SkillCard(skill: "Reading", progress: 0.85),
            _SkillCard(skill: "Writing", progress: 0.50),
          ],
        ),
      ],
    );
  }
}

class _SkillCard extends StatelessWidget {
  final String skill;
  final double progress;
  const _SkillCard({required this.skill, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(skill, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text("${(progress * 100).toInt()}%",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
            ],
          ),
          const Spacer(),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            color: const Color(0xFF0D47A1),
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}

// 3. Requirements Section
class RequirementsSection extends StatelessWidget {
  const RequirementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("To B1, you need:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A252F))),
        SizedBox(height: 12),
        _RequirementItem(
            text: "Learn 350 – 400 words", isCompleted: true),
        _RequirementItem(
            text: "Know 15 grammar points", isCompleted: false),
        _RequirementItem(
            text: "Complete 10 reading exercises", isCompleted: true),
        _RequirementItem(
            text: "Write 5 short paragraphs", isCompleted: false),
      ],
    );
  }
}

class _RequirementItem extends StatelessWidget {
  final String text;
  final bool isCompleted;
  const _RequirementItem({required this.text, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.highlight_off,
            color: isCompleted ? Colors.green : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

// 4. CEFR Roadmap Card
class CefrRoadmapCard extends StatelessWidget {
  const CefrRoadmapCard({super.key});

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
              "CEFR Roadmap",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _RoadmapStep(level: "A1", status: RoadmapStatus.completed),
                _RoadmapStep(level: "A2", status: RoadmapStatus.completed),
                _RoadmapStep(level: "B1", status: RoadmapStatus.current),
                _RoadmapStep(level: "B2", status: RoadmapStatus.future),
                _RoadmapStep(level: "C1", status: RoadmapStatus.future),
                _RoadmapStep(level: "C2", status: RoadmapStatus.future),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum RoadmapStatus { completed, current, future }

class _RoadmapStep extends StatelessWidget {
  final String level;
  final RoadmapStatus status;
  const _RoadmapStep({required this.level, required this.status});

  @override
  Widget build(BuildContext context) {
    Color dotColor;
    Color borderColor = Colors.transparent;
    Widget? topLabel;

    switch (status) {
      case RoadmapStatus.completed:
        dotColor = Colors.green;
        break;
      case RoadmapStatus.current:
        dotColor = Colors.white;
        borderColor = const Color(0xFF0D47A1);
        topLabel = const Text(
          "Current",
          style: TextStyle(
              fontSize: 10,
              color: Color(0xFF0D47A1),
              fontWeight: FontWeight.bold),
        );
        break;
      case RoadmapStatus.future:
        dotColor = Colors.grey[300]!;
        break;
    }

    return Column(
      children: [
        if (topLabel != null) topLabel else const SizedBox(height: 12),
        const SizedBox(height: 4),
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 2),
          ),
          child: status == RoadmapStatus.completed
              ? const Icon(Icons.check, color: Colors.white, size: 14)
              : null,
        ),
        const SizedBox(height: 8),
        Text(level,
            style: TextStyle(
                fontWeight: status == RoadmapStatus.current
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: status == RoadmapStatus.future
                    ? Colors.grey
                    : const Color(0xFF1A252F))),
      ],
    );
  }
}
