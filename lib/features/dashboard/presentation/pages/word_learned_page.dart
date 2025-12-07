import 'package:flutter/material.dart';

// --- MÀN HÌNH CHÍNH (WORD LEARNED SCREEN) ---
class WordLearnedScreen extends StatefulWidget {
  const WordLearnedScreen({super.key});

  @override
  State<WordLearnedScreen> createState() => _WordLearnedScreenState();
}

class _WordLearnedScreenState extends State<WordLearnedScreen> {
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
          'Word Learned',
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_outline, color: darkText),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                // 1) Summary hero card
                SummaryHeroCard(wordCount: 120),
                SizedBox(height: 16),

                // 2) Time range stats row
                TimeRangeStatsRow(),
                SizedBox(height: 24),

                // 3) CEFR Progress (Words Learned)
                CefrProgressSection(),
                SizedBox(height: 24),

                // 4) Part-of-speech distribution row
                PartOfSpeechDistribution(),
                SizedBox(height: 24),

                // 5) Search and filter bar
                SearchAndFilterBar(),
                SizedBox(height: 16),

                // 6) Learned word list
                LearnedWordList(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
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
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: 'Vocab'),
          BottomNavigationBarItem(icon: Icon(Icons.spellcheck_outlined), label: 'Grammar'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// --- CÁC WIDGET THÀNH PHẦN ---

// 1. Summary Hero Card
class SummaryHeroCard extends StatelessWidget {
  final int wordCount;
  const SummaryHeroCard({super.key, required this.wordCount});

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
          const Icon(Icons.water_drop_outlined, color: Color(0xFF0D47A1), size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You’ve learned $wordCount words",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A252F),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Keep up the great work",
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

// 2. Time Range Stats Row
class TimeRangeStatsRow extends StatelessWidget {
  const TimeRangeStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _TimeStatCard(title: "Today", value: "5 w")),
        SizedBox(width: 12),
        Expanded(child: _TimeStatCard(title: "This week", value: "30 w")),
        SizedBox(width: 12),
        Expanded(child: _TimeStatCard(title: "This month", value: "120 w")),
      ],
    );
  }
}

class _TimeStatCard extends StatelessWidget {
  final String title;
  final String value;
  const _TimeStatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// 3. CEFR Progress Section
class CefrProgressSection extends StatelessWidget {
  const CefrProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "CEFR Progress (Words Learned)",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A252F)),
        ),
        const SizedBox(height: 12),
        _CefrProgressRow(level: "A1", progress: 1.0, color: Colors.green),
        _CefrProgressRow(level: "A2", progress: 0.75, color: Colors.blue),
        _CefrProgressRow(level: "B1", progress: 0.3, color: Colors.orange),
        _CefrProgressRow(level: "B2", progress: 0.0, color: Colors.red),
        _CefrProgressRow(level: "C1", progress: 0.0, color: Colors.purple),
        _CefrProgressRow(level: "C2", progress: 0.0, color: Colors.black),
      ],
    );
  }
}

class _CefrProgressRow extends StatelessWidget {
  final String level;
  final double progress;
  final Color color;
  const _CefrProgressRow({required this.level, required this.progress, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 35,
            child: Text(
              level,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                color: const Color(0xFF0D47A1),
                minHeight: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 4. Part-of-Speech Distribution
class PartOfSpeechDistribution extends StatelessWidget {
  const PartOfSpeechDistribution({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _SpeechPartItem(label: "Noun", count: "40", color: Colors.blue),
        _SpeechPartItem(label: "Verb", count: "35", color: Colors.green),
        _SpeechPartItem(label: "Adj", count: "25", color: Colors.orange),
        _SpeechPartItem(label: "Adv", count: "15", color: Colors.purple),
        _SpeechPartItem(label: "Other", count: "5", color: Colors.grey),
      ],
    );
  }
}

class _SpeechPartItem extends StatelessWidget {
  final String label;
  final String count;
  final Color color;
  const _SpeechPartItem({required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 4),
        Text(count, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// 5. Search and Filter Bar
class SearchAndFilterBar extends StatelessWidget {
  const SearchAndFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search learned word...",
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
            color: Colors.grey[700],
          ),
        )
      ],
    );
  }
}

// 6. Learned Word List
class LearnedWordList extends StatelessWidget {
  const LearnedWordList({super.key});

  @override
  Widget build(BuildContext context) {
    // Sử dụng Column cho ví dụ. Trong thực tế, nên dùng ListView.builder.
    return Column(
      children: const [
        _LearnedWordCard(
          word: "structure",
          ipa: "/ˈstrʌk.tʃər/",
          meaning: "Framework",
          learnedDate: "19/12/2025",
        ),
        SizedBox(height: 12),
        _LearnedWordCard(
          word: "serendipity",
          ipa: "/ˌser.ənˈdɪp.ə.ti/",
          meaning: "Finding good things without looking",
          learnedDate: "18/12/2025",
        ),
      ],
    );
  }
}

class _LearnedWordCard extends StatelessWidget {
  final String word;
  final String ipa;
  final String meaning;
  final String learnedDate;

  const _LearnedWordCard({
    required this.word,
    required this.ipa,
    required this.meaning,
    required this.learnedDate,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(word, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(ipa, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  const SizedBox(height: 8),
                  Text("Meaning: $meaning", style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                  Text("Learned on: $learnedDate", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF673AB7), // Soft purple
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              child: const Text("View details"),
            )
          ],
        ),
      ),
    );
  }
}

