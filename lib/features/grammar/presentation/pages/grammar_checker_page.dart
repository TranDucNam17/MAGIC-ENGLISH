import 'package:flutter/material.dart';
import 'grammar_check_detail_page.dart';

class GrammarCheckerScreen extends StatefulWidget {
  const GrammarCheckerScreen({super.key});

  @override
  State<GrammarCheckerScreen> createState() => _GrammarCheckerScreenState();
}

class _GrammarCheckerScreenState extends State<GrammarCheckerScreen> {
  final List<Map<String, String>> _historyItems = [
    {"errors": "5", "date": "12/1/2025", "status": "Done"},
    {"errors": "2", "date": "11/30/2025", "status": "Done"},
    {"errors": "8", "date": "11/28/2025", "status": "Done"},
  ];

  @override
  Widget build(BuildContext context) {
    const Color lightBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);

    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.grey.withOpacity(0.2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Grammar Checker',
          style: TextStyle(
              color: darkText, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // --- CÁC THÀNH PHẦN CHÍNH ---
                      const _InputCard(),
                      const SizedBox(height: 16),
                      const _AiResultCard(),
                      const SizedBox(height: 16),
                      const _SearchHistoryBar(),
                      const SizedBox(height: 12),
                      _buildHistoryList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _historyItems.length,
      itemBuilder: (context, index) {
        final item = _historyItems[index];
        return _HistoryItemCard(
          errors: item['errors']!,
          date: item['date']!,
          status: item['status']!,
        );
      },
    );
  }
}

class _InputCard extends StatelessWidget {
  const _InputCard();

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);

    return Card(
      elevation: 2.0,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              maxLines: 6,
              decoration: InputDecoration(
                hintText: "Write something...",
                border: InputBorder.none,
                filled: false,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("AI Tips & Example"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Run check"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AiResultCard extends StatelessWidget {
  const _AiResultCard();

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);

    return Card(
      elevation: 2.0,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("AI Result",
                style: TextStyle(
                    color: primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            const SizedBox(height: 12),
            // Các dòng kết quả
            _buildResultLine("Level: ", "B2", primaryBlue),
            _buildResultLine("Found: ", "2 errors", Colors.red.shade700),
            const SizedBox(height: 12),
            const Text("Grammar error list:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            _buildErrorLine("'iss' → 'is'"),
            _buildErrorLine("'penh' → 'pen'"),
            const SizedBox(height: 12),
            _buildSuggestionLine("Suggestion: This is my pen"),
          ],
        ),
      ),
    );
  }

  Widget _buildResultLine(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          children: [
            TextSpan(text: label),
            TextSpan(
                text: value,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: valueColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorLine(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2.0, bottom: 2.0),
      child: Text("• $text",
          style: TextStyle(color: Colors.red.shade700, fontSize: 14)),
    );
  }

  Widget _buildSuggestionLine(String text) {
    return Text(text,
        style: TextStyle(
            color: Colors.green.shade800,
            fontSize: 14,
            fontWeight: FontWeight.w500));
  }
}

class _SearchHistoryBar extends StatelessWidget {
  const _SearchHistoryBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search history",
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

class _HistoryItemCard extends StatelessWidget {
  final String errors;
  final String date;
  final String status;

  const _HistoryItemCard({
    required this.errors,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    const Color accentPurple = Color(0xFF673AB7);

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2.0,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Thông tin
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Grammar – $errors errors – $date",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("Status: $status",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            // Nút xem chi tiết
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GrammarCheckDetailScreen(),
                    fullscreenDialog: true,
                    ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accentPurple.withOpacity(0.8),
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                textStyle: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold),
              ),
              child: const Text("View detail"),
            ),
          ],
        ),
      ),
    );
  }
}
