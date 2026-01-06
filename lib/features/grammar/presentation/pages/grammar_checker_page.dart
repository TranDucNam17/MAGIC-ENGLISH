import 'package:flutter/material.dart';
import 'grammar_check_detail_page.dart';
import 'grammar_tips_examples_page.dart';
import '../../data/services/grammar_api_service.dart';

class GrammarCheckerScreen extends StatefulWidget {
  const GrammarCheckerScreen({super.key});

  @override
  State<GrammarCheckerScreen> createState() => _GrammarCheckerScreenState();
}

class _GrammarCheckerScreenState extends State<GrammarCheckerScreen> {
  final TextEditingController _inputController = TextEditingController();
  bool _isLoading = false;
  bool _isLoadingHistory = false;
  Map<String, dynamic>? _checkResult;
  List<Map<String, dynamic>> _historyItems = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    setState(() => _isLoadingHistory = true);
    try {
      final history = await GrammarApiService.getHistory();
      setState(() {
        _historyItems = history;
        _isLoadingHistory = false;
      });
    } catch (e) {
      print('Error loading history: $e');
      setState(() => _isLoadingHistory = false);
    }
  }

  Future<void> _handleRunCheck() async {
    if (_inputController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please write something first")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Call real API via GrammarApiService
      final result = await GrammarApiService.checkGrammar(
        _inputController.text,
      );

      setState(() {
        _checkResult = result;
        _isLoading = false;
      });

      // Reload history to show the new check
      await _loadHistory();
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
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
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // --- CÁC THÀNH PHẦN CHÍNH ---
                      _InputCard(
                        controller: _inputController,
                        isLoading: _isLoading,
                        onRunCheck: _handleRunCheck,
                        onAiTips: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const GrammarTipsExamplesScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      if (_checkResult != null)
                        _AiResultCard(checkResult: _checkResult!)
                      else
                        const _AiResultCardEmpty(),
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
    if (_isLoadingHistory) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_historyItems.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Icon(Icons.history, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 12),
              Text(
                "No grammar check history yet",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _historyItems.length,
      itemBuilder: (context, index) {
        final item = _historyItems[index];
        return _HistoryItemCard(checkData: item);
      },
    );
  }
}

class _InputCard extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onRunCheck;
  final VoidCallback onAiTips;

  const _InputCard({
    required this.controller,
    required this.isLoading,
    required this.onRunCheck,
    required this.onAiTips,
  });

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
            TextField(
              controller: controller,
              maxLines: 6,
              decoration: const InputDecoration(
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
                  onPressed: isLoading ? null : onAiTips,
                  child: const Text("AI Tips & Example"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: isLoading ? null : onRunCheck,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text("Run check"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AiResultCardEmpty extends StatelessWidget {
  const _AiResultCardEmpty();

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
            const Text(
              "AI Result",
              style: TextStyle(
                color: primaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "No result yet. Write something and click 'Run check'",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _AiResultCard extends StatefulWidget {
  final Map<String, dynamic> checkResult;

  const _AiResultCard({required this.checkResult});

  @override
  State<_AiResultCard> createState() => _AiResultCardState();
}

class _AiResultCardState extends State<_AiResultCard> {
  bool _showSuggestions = false;

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    final errorCount = widget.checkResult['errors_count'] ?? 0;

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
            const Text(
              "AI Result",
              style: TextStyle(
                color: primaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            _buildResultLine(
              "Level: ",
              widget.checkResult['level'] ?? "N/A",
              primaryBlue,
            ),
            _buildResultLine(
              "Found: ",
              "$errorCount error${errorCount != 1 ? 's' : ''}",
              Colors.red.shade700,
            ),
            const SizedBox(height: 12),
            const Text(
              "Grammar error list:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (errorCount == 0)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "✓ No errors found!",
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            else
              ...((widget.checkResult['errors'] as List?)?.asMap().entries.map((
                    entry,
                  ) {
                    int index = entry.key;
                    var error = entry.value;
                    return _buildDetailedErrorCard(
                      index + 1,
                      error['original'] ?? 'Unknown',
                      error['correction'] ?? 'No suggestion',
                      error['description'] ?? 'Grammar error',
                      error['type'] ?? 'Error',
                    );
                  }).toList() ??
                  []),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                setState(() => _showSuggestions = !_showSuggestions);
              },
              icon: Icon(
                _showSuggestions ? Icons.expand_less : Icons.expand_more,
              ),
              label: Text(
                _showSuggestions ? "Hide Suggestion" : "Show AI Tips & Example",
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue.withOpacity(0.8),
                foregroundColor: Colors.white,
              ),
            ),
            if (_showSuggestions) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Suggestion:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.checkResult['corrected_text'] ?? "N/A",
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
              style: TextStyle(fontWeight: FontWeight.bold, color: valueColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorLine(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2.0, bottom: 2.0),
      child: Text(
        "• $text",
        style: TextStyle(color: Colors.red.shade700, fontSize: 14),
      ),
    );
  }

  Widget _buildDetailedErrorCard(
    int index,
    String original,
    String correction,
    String description,
    String type,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red.shade200),
          borderRadius: BorderRadius.circular(8),
          color: Colors.red.shade50,
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.red.shade700,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '"$original"',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A252F),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  const Text(
                    "✓ Suggestion: ",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '"$correction"',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
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
  final Map<String, dynamic> checkData;

  const _HistoryItemCard({required this.checkData});

  @override
  Widget build(BuildContext context) {
    const Color accentPurple = Color(0xFF673AB7);

    final errorCount = checkData['errors_count'] ?? 0;
    final originalText = checkData['original_text'] ?? '';
    final createdAt = checkData['created_at'] ?? '';

    // Format date from ISO format to readable format
    String formattedDate = createdAt;
    try {
      if (createdAt.isNotEmpty) {
        final dateTime = DateTime.parse(createdAt);
        formattedDate = '${dateTime.month}/${dateTime.day}/${dateTime.year}';
      }
    } catch (e) {
      // Keep original if parsing fails
    }

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
                  Text(
                    "Grammar – $errorCount error${errorCount != 1 ? 's' : ''} – $formattedDate",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    originalText.length > 50
                        ? '${originalText.substring(0, 50)}...'
                        : originalText,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Nút xem chi tiết
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GrammarCheckDetailScreen(checkData: checkData),
                    fullscreenDialog: true,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accentPurple.withOpacity(0.8),
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text("View detail"),
            ),
          ],
        ),
      ),
    );
  }
}
