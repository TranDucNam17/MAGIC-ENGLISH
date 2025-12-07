import 'package:flutter/material.dart';

// --- MÀN HÌNH CHÍNH (PART OF SPEECH SCREEN) ---
class PartOfSpeechScreen extends StatefulWidget {
  const PartOfSpeechScreen({super.key});

  @override
  State<PartOfSpeechScreen> createState() => _PartOfSpeechScreenState();
}

class _PartOfSpeechScreenState extends State<PartOfSpeechScreen> {
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
          'Part of Speech',
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
                // 1) Summary hero card
                SummaryHeroCard(wordCount: 120, posCount: 8),
                SizedBox(height: 24),

                // 2) Part-of-speech progress card
                PartOfSpeechProgressCard(),
                SizedBox(height: 24),

                // 3) Definition cards
                DefinitionCardsList(),
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

// 1. Summary Hero Card
class SummaryHeroCard extends StatelessWidget {
  final int wordCount;
  final int posCount;
  const SummaryHeroCard({super.key, required this.wordCount, required this.posCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "You have learned $wordCount words across $posCount parts of speech",
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A252F)),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                "Keep building your vocabulary",
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              const Spacer(),
              const Icon(Icons.water_drop_outlined,
                  color: Color(0xFF0D47A1), size: 20),
            ],
          ),
        ],
      ),
    );
  }
}

// 2. Part-of-Speech Progress Card
class PartOfSpeechProgressCard extends StatelessWidget {
  const PartOfSpeechProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            _PoSProgressRow(label: "N", progress: 0.8, color: Colors.blue),
            _PoSProgressRow(label: "V", progress: 0.7, color: Colors.green),
            _PoSProgressRow(label: "Adj", progress: 0.6, color: Colors.orange),
            _PoSProgressRow(label: "Adv", progress: 0.4, color: Colors.purple),
            _PoSProgressRow(label: "Prep", progress: 0.9, color: Colors.teal),
            _PoSProgressRow(label: "Pron", progress: 1.0, color: Colors.pink),
            _PoSProgressRow(label: "Conj", progress: 0.5, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class _PoSProgressRow extends StatelessWidget {
  final String label;
  final double progress;
  final Color color;

  const _PoSProgressRow({
    required this.label,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: color, fontSize: 16),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.grey[200],
                color: const Color(0xFF0D47A1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 3. Definition Cards List
class DefinitionCardsList extends StatelessWidget {
  const DefinitionCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        DefinitionCard(
          title: "What is a Noun?",
          definition: "A noun is a word that refers to a person, place, thing, or idea. It serves as the subject or object of a verb.",
          example: "book, happiness, teacher, computer",
        ),
        SizedBox(height: 16),
        DefinitionCard(
          title: "What is a Verb?",
          definition: "A verb is a word used to describe an action, state, or occurrence. It forms the main part of the predicate of a sentence.",
          example: "run, study, think, become",
        ),
        SizedBox(height: 16),
        DefinitionCard(
          title: "What is an Adjective?",
          definition: "An adjective is a word that modifies or describes a noun or pronoun, providing more information about its qualities.",
          example: "beautiful, smart, blue, happy",
        ),
      ],
    );
  }
}

class DefinitionCard extends StatelessWidget {
  final String title;
  final String definition;
  final String example;

  const DefinitionCard({
    super.key,
    required this.title,
    required this.definition,
    required this.example,
  });

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
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A252F),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              definition,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5, // Tăng khoảng cách dòng cho dễ đọc
              ),
            ),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto', // Đảm bảo font nhất quán
                  color: Colors.grey[700],
                ),
                children: [
                  const TextSpan(
                    text: 'Example: ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: example,
                    style: const TextStyle(fontStyle: FontStyle.italic),
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
