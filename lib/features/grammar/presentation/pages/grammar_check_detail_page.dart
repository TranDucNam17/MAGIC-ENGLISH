import 'package:flutter/material.dart';

class GrammarCheckDetailScreen extends StatelessWidget {
  final Map<String, dynamic> checkData;

  const GrammarCheckDetailScreen({super.key, required this.checkData});

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
          icon: const Icon(Icons.close, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Grammar Check Detail',
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _HeaderSummaryCard(checkData: checkData),
                const SizedBox(height: 16),
                _OriginalTextSection(checkData: checkData),
                const SizedBox(height: 16),
                _ErrorsFoundSection(checkData: checkData),
                const SizedBox(height: 16),
                _CorrectionSection(checkData: checkData),
                const SizedBox(height: 24),
                const _BottomAction(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderSummaryCard extends StatelessWidget {
  final Map<String, dynamic> checkData;

  const _HeaderSummaryCard({required this.checkData});

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';
    try {
      final dateTime = DateTime.parse(dateString);
      return '${dateTime.month}/${dateTime.day}/${dateTime.year}';
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final level = checkData['level'] ?? 'B1';
    final errorCount = checkData['errors_count'] ?? 0;
    final date = _formatDate(checkData['created_at']);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFFE3F2FD),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Grammar Check – $date",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Level: $level",
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Status: Done",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
                Text(
                  "Total Errors: $errorCount",
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OriginalTextSection extends StatelessWidget {
  final Map<String, dynamic> checkData;

  const _OriginalTextSection({required this.checkData});

  @override
  Widget build(BuildContext context) {
    final originalText = checkData['original_text'] ?? 'N/A';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: "Original Text"),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            originalText,
            style: const TextStyle(fontSize: 14, color: Color(0xFF424242)),
          ),
        ),
      ],
    );
  }
}

class _ErrorsFoundSection extends StatelessWidget {
  final Map<String, dynamic> checkData;

  const _ErrorsFoundSection({required this.checkData});

  @override
  Widget build(BuildContext context) {
    final errors = checkData['errors'] as List<dynamic>? ?? [];

    if (errors.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(title: "Errors Found"),
          const SizedBox(height: 8),
          Card(
            elevation: 1.5,
            shadowColor: Colors.grey.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.green.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green.shade600,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "No errors found. Your text is correct!",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: "Errors Found"),
        const SizedBox(height: 8),
        Card(
          elevation: 1.5,
          shadowColor: Colors.grey.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ...errors
                    .asMap()
                    .entries
                    .map((entry) {
                      final index = entry.key + 1;
                      final error = entry.value as Map<String, dynamic>;
                      return _buildErrorRow(
                        index,
                        error['type'] ?? 'Grammar',
                        error['original'] ?? 'Unknown',
                        error['description'] ?? 'Error found',
                      );
                    })
                    .toList()
                    .expand((widget) => [widget, const Divider()])
                    .toList()
                  ..removeLast(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorRow(
    int index,
    String type,
    String original,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.shade100,
                ),
                child: Center(
                  child: Text(
                    '$index',
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
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
                      "'$original'",
                      style: TextStyle(
                        color: Colors.red.shade800,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "$type: $description",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CorrectionSection extends StatelessWidget {
  final Map<String, dynamic> checkData;

  const _CorrectionSection({required this.checkData});

  @override
  Widget build(BuildContext context) {
    final errors = checkData['errors'] as List<dynamic>? ?? [];
    final correctedText = checkData['corrected_text'] ?? 'N/A';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: "Suggestions"),
        const SizedBox(height: 8),
        Card(
          elevation: 1.5,
          shadowColor: Colors.grey.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (errors.isNotEmpty) ...[
                  const Text(
                    "Corrections:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A252F),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...errors.asMap().entries.map((entry) {
                    var error = entry.value as Map<String, dynamic>;
                    return _buildCorrectionRow(
                      error['original'] ?? 'Unknown',
                      error['correction'] ?? 'No suggestion',
                    );
                  }).toList(),
                  const Divider(height: 24),
                ],
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                    children: [
                      const TextSpan(
                        text: "Result: ",
                        style: TextStyle(
                          color: Color(0xFF0D47A1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: correctedText,
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCorrectionRow(String original, String correction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(Icons.check, color: Colors.green.shade600, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "'$original' → '$correction'",
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomAction extends StatelessWidget {
  const _BottomAction();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: OutlinedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF0D47A1),
          side: const BorderSide(color: Color(0xFF0D47A1)),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: const Text("Cancel"),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A252F),
      ),
    );
  }
}
