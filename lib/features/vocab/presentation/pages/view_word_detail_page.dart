// lib/presentation/dashboard/view_word_detail_screen.dart

import 'package:flutter/material.dart';

// --- MÀN HÌNH CHÍNH (VIEW WORD DETAIL SCREEN) ---
class ViewWordDetailScreen extends StatelessWidget {
  // Dữ liệu giả cho từ vựng được xem
  final Map<String, String> wordData;

  const ViewWordDetailScreen({
    super.key,
    required this.wordData,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color lightBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);
    const Color accentGreen = Color(0xFF66DDAA);

    return Scaffold(
      backgroundColor: lightBackground,
      // 1. AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.grey.withOpacity(0.2),
        leading: IconButton(
          icon: const Icon(Icons.close, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(wordData['word'] ?? 'View Details'),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- CÁC TRƯỜNG DỮ LIỆU (CHỈ ĐỌC) ---
                  _ReadOnlyTextField(label: "Word", value: wordData['word']),
                  const SizedBox(height: 12),
                  // Nút AI Enrich bị vô hiệu hóa
                  const _AiEnrichButton(enabled: false),
                  const SizedBox(height: 16),
                  _ReadOnlyTextField(label: "IPA", value: wordData['ipa']),
                  const SizedBox(height: 16),
                  _ReadOnlyTextField(
                    label: "Meaning (Vietnamese)",
                    value: wordData['meaning'],
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  _ReadOnlyTextField(label: "Part of speech", value: wordData['partOfSpeech']),
                  const SizedBox(height: 16),
                  _buildCefrDropdown(wordData['cefr']),
                  const SizedBox(height: 16),
                  _ReadOnlyTextField(label: "Topic", value: wordData['topic']),
                  const SizedBox(height: 16),
                  _ReadOnlyTextField(
                    label: "Synonyms",
                    value: wordData['synonyms'],
                  ),
                  const SizedBox(height: 16),
                  _ReadOnlyTextField(label: "Notes", value: wordData['notes'], maxLines: 3),
                  const SizedBox(height: 16),
                  _ReadOnlyTextField(
                    label: "Example",
                    value: wordData['example'],
                    maxLines: 4,
                  ),
                  const SizedBox(height: 24),
                  // --- CÁC NÚT HÀNH ĐỘNG ---
                  Row(
                    children: [
                      // Nút Cancel (vẫn hoạt động)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primaryBlue,
                            side: const BorderSide(color: primaryBlue, width: 1.5),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Nút Save word (bị vô hiệu hóa)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: null, // Vô hiệu hóa nút
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
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
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget riêng cho Dropdown CEFR (chỉ đọc)
  Widget _buildCefrDropdown(String? value) {
    // AbsorbPointer ngăn mọi tương tác chạm vào widget con của nó
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
            value: value,
            onChanged: null, // Vô hiệu hóa sự kiện thay đổi
            items: <String>['A1', 'A2', 'B1', 'B2', 'C1', 'C2']
                .map<DropdownMenuItem<String>>((String val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(val),
              );
            }).toList(),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              // Màu nền khi bị vô hiệu hóa
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

// --- CÁC WIDGET THÀNH PHẦN (CHỈ ĐỌC) ---

// Widget chung cho các trường TextFormField (chỉ đọc)
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF616161), fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: TextEditingController(text: value),
          readOnly: true, // Quan trọng: chỉ cho phép đọc
          maxLines: maxLines,
          style: const TextStyle(color: Color(0xFF424242)), // Màu chữ đậm hơn một chút
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            // Border khi bị disable, giống như enabled để không thay đổi màu
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

// Widget cho nút AI Enrich
class _AiEnrichButton extends StatelessWidget {
  final bool enabled;
  const _AiEnrichButton({this.enabled = true});

  @override
  Widget build(BuildContext context) {
    const Color accentGreen = Color(0xFF66DDAA);
    return ElevatedButton(
      onPressed: enabled ? () {} : null, // Vô hiệu hóa nút
      style: ElevatedButton.styleFrom(
        backgroundColor: accentGreen,
        foregroundColor: const Color(0xFF003D23),
        // Giảm độ sáng khi bị vô hiệu hóa
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
          Text(
            "AI Enrich",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
