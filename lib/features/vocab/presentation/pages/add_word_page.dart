// lib/presentation/dashboard/add_word_screen.dart

import 'package:flutter/material.dart';

// --- MÀN HÌNH CHÍNH (ADD WORD SCREEN) ---
class AddWordScreen extends StatefulWidget {
  const AddWordScreen({super.key});

  @override
  State<AddWordScreen> createState() => _AddWordScreenState();
}

class _AddWordScreenState extends State<AddWordScreen> {
  // Biến để lưu giá trị được chọn trong Dropdown
  String? _selectedCefrLevel;

  // GlobalKey cho Form để sau này có thể validate
  final _formKey = GlobalKey<FormState>();

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
        // Nút 'X' để đóng
        leading: IconButton(
          icon: const Icon(Icons.close, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // Tiêu đề căn trái
        title: const Text(
          'Add Word',
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        titleSpacing: 0, // Bỏ khoảng trống mặc định bên trái tiêu đề
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- CÁC TRƯỜNG NHẬP LIỆU ---
                  const _FormTextField(label: "Word"),
                  const SizedBox(height: 12),
                  const _AiEnrichButton(),
                  const SizedBox(height: 16),
                  const _FormTextField(label: "IPA"),
                  const SizedBox(height: 16),
                  const _FormTextField(
                    label: "Meaning (Vietnamese)",
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  const _FormTextField(label: "Part of speech"),
                  const SizedBox(height: 16),
                  _buildCefrDropdown(), // Dropdown cho CEFR Level
                  const SizedBox(height: 16),
                  const _FormTextField(label: "Topic"),
                  const SizedBox(height: 16),
                  const _FormTextField(
                    label: "Synonyms",
                    hint: "framework, form",
                  ),
                  const SizedBox(height: 16),
                  const _FormTextField(label: "Notes", maxLines: 3),
                  const SizedBox(height: 16),
                  const _FormTextField(
                    label: "Example",
                    maxLines: 4,
                    hint: "Data structures and algorithms are...",
                  ),
                  const SizedBox(height: 24),

                  // --- CÁC NÚT HÀNH ĐỘNG ---
                  Row(
                    children: [
                      // Nút Cancel
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Nút Save Word
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Xử lý logic lưu từ
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Save word",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
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

  // Widget riêng cho Dropdown CEFR
  Widget _buildCefrDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "CEFR Level",
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: _selectedCefrLevel,
          onChanged: (String? newValue) {
            setState(() {
              _selectedCefrLevel = newValue;
            });
          },
          items: <String>['A1', 'A2', 'B1', 'B2', 'C1', 'C2']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }
}

// --- CÁC WIDGET THÀNH PHẦN CHO FORM ---

// Widget chung cho các trường TextFormField
class _FormTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final int maxLines;

  const _FormTextField({
    required this.label,
    this.hint,
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
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}

// Widget cho nút AI Enrich
class _AiEnrichButton extends StatelessWidget {
  const _AiEnrichButton();

  @override
  Widget build(BuildContext context) {
    const Color accentGreen = Color(0xFF66DDAA);
    return ElevatedButton(
      onPressed: () {
        // TODO: Placeholder cho chức năng AI
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: accentGreen,
        foregroundColor: const Color(0xFF003D23),
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
