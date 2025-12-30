import 'package:flutter/material.dart';

class ViewWordDetailScreen extends StatelessWidget {
  final Map<String, dynamic> wordData;

  const ViewWordDetailScreen({super.key, required this.wordData});

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
        title: Text(wordData['term']?.toString() ?? 'View Details'),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ReadOnlyTextField(
                    label: "Word",
                    value: wordData['term']?.toString(),
                  ),
                  const SizedBox(height: 12),
                  const _AiEnrichButton(enabled: false),
                  const SizedBox(height: 16),
                  _ReadOnlyTextField(
                    label: "IPA",
                    value: wordData['ipa']?.toString(),
                  ),
                  const SizedBox(height: 16),
                  _ReadOnlyTextField(
                    label: "Meaning (Vietnamese)",
                    value: wordData['note']?.toString(),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  _ReadOnlyTextField(
                    label: "Part of speech",
                    value: wordData['pos']?.toString(),
                  ),
                  const SizedBox(height: 16),
                  _buildCefrDropdown(wordData['cefr']?.toString()),
                  const SizedBox(height: 16),
                  _ReadOnlyTextField(
                    label: "Example (English)",
                    value: wordData['example_en']?.toString(),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  _ReadOnlyTextField(
                    label: "Example (Vietnamese)",
                    value: wordData['example_vi']?.toString(),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.blueAccent,
                            side: const BorderSide(
                              color: Colors.blueAccent,
                              width: 1.5,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: null, // Vô hiệu hóa nút
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            disabledBackgroundColor: Colors.grey.shade300,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Save word",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCefrDropdown(String? value) {
    final cefrLevels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
    final displayValue = value != null && cefrLevels.contains(value)
        ? value
        : 'B1';

    return AbsorbPointer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "CEFR Level",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 4),
          DropdownButtonFormField<String>(
            initialValue: displayValue,
            onChanged: null,
            items: cefrLevels.map<DropdownMenuItem<String>>((String val) {
              return DropdownMenuItem<String>(value: val, child: Text(val));
            }).toList(),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadOnlyTextField extends StatelessWidget {
  final String label;
  final String? value;
  final int maxLines;

  const _ReadOnlyTextField({
    required this.label,
    this.value,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue = value?.isEmpty ?? true ? '-' : value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF616161),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: TextEditingController(text: displayValue),
          readOnly: true,
          maxLines: maxLines,
          style: const TextStyle(color: Color(0xFF424242)),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }
}

class _AiEnrichButton extends StatelessWidget {
  final bool enabled;
  const _AiEnrichButton({this.enabled = true});

  @override
  Widget build(BuildContext context) {
    const Color accentGreen = Color(0xFF66DDAA);
    return ElevatedButton(
      onPressed: enabled ? () {} : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: accentGreen,
        foregroundColor: const Color(0xFF003D23),
        disabledBackgroundColor: accentGreen.withOpacity(0.4),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 10),
        elevation: 1,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome, size: 18),
          SizedBox(width: 8),
          Text("AI Enrich", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
