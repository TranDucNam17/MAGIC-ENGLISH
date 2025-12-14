import 'package:flutter/material.dart';

class GrammarCheckDetailScreen extends StatelessWidget {
  const GrammarCheckDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color lightBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);
    const Color primaryBlue = Color(0xFF0D47A1);

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
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _HeaderSummaryCard(),
                const SizedBox(height: 16),
                const _OriginalTextSection(),
                const SizedBox(height: 16),
                const _ErrorsFoundSection(),
                const SizedBox(height: 16),
                const _CorrectionSection(),
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
  const _HeaderSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFFE3F2FD),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Grammar Check – 12/1/2025",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Level: B2",
                        style: TextStyle(color: Colors.grey[800])),
                    const SizedBox(height: 4),
                    Text("Status: Done",
                        style: TextStyle(color: Colors.grey[700])),
                  ],
                ),
                Text(
                  "Total Errors: 3",
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
  const _OriginalTextSection();

  @override
  Widget build(BuildContext context) {
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
          child: const Text(
            "This iss my penh’",
            style: TextStyle(fontSize: 14, color: Color(0xFF424242)),
          ),
        ),
      ],
    );
  }
}

class _ErrorsFoundSection extends StatelessWidget {
  const _ErrorsFoundSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: "Errors Found"),
        const SizedBox(height: 8),
        Card(
          elevation: 1.5,
          shadowColor: Colors.grey.withOpacity(0.1),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildErrorRow("'iss'"),
                const Divider(),
                _buildErrorRow("'penh'"),
                const Divider(),
                _buildErrorRow("Thiếu dấu chấm"),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildErrorRow(String errorText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.close, color: Colors.red.shade600, size: 20),
          const SizedBox(width: 8),
          Text(
            errorText,
            style: TextStyle(
                color: Colors.red.shade800,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _CorrectionSection extends StatelessWidget {
  const _CorrectionSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: "Correction"),
        const SizedBox(height: 8),
        Card(
          elevation: 1.5,
          shadowColor: Colors.grey.withOpacity(0.1),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCorrectionRow("'iss' → 'is'"),
                const Divider(),
                _buildCorrectionRow("'penh' → 'pen'"),
                const Divider(height: 24),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                    children: [
                      const TextSpan(
                        text: "Result: ",
                        style: TextStyle(
                            color: Color(0xFF0D47A1),
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "This is my pen.",
                        style: TextStyle(
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.w500),
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

  Widget _buildCorrectionRow(String correctionText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.check, color: Colors.green.shade600, size: 20),
          const SizedBox(width: 8),
          Text(correctionText, style: const TextStyle(fontSize: 14)),
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
