// lib/presentation/dashboard/edit_word_screen.dart

import 'package:flutter/material.dart';

// --- MÀN HÌNH CHÍNH (EDIT WORD SCREEN) ---
class EditWordScreen extends StatefulWidget {
  // Nhận dữ liệu của từ cần chỉnh sửa
  final Map<String, String> wordData;

  const EditWordScreen({super.key, required this.wordData});

  @override
  State<EditWordScreen> createState() => _EditWordScreenState();
}

class _EditWordScreenState extends State<EditWordScreen> {
  // Sử dụng các controller để điền sẵn dữ liệu vào TextFormField
  late final TextEditingController _wordController;
  late final TextEditingController _ipaController;
  late final TextEditingController _meaningController;
  late final TextEditingController _posController;
  late final TextEditingController _topicController;
  late final TextEditingController _synonymsController;
  late final TextEditingController _notesController;
  late final TextEditingController _exampleController;

  String? _selectedCefrLevel;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Khởi tạo các controller với dữ liệu được truyền vào
    final data = widget.wordData;
    _wordController = TextEditingController(text: data['word']);
    _ipaController = TextEditingController(text: data['ipa']);
    _meaningController = TextEditingController(text: data['meaning']);
    _posController = TextEditingController(text: data['partOfSpeech']);
    _topicController = TextEditingController(text: data['topic']);
    _synonymsController = TextEditingController(text: data['synonyms']);
    _notesController = TextEditingController(text: data['notes']);
    _exampleController = TextEditingController(text: data['example']);
    _selectedCefrLevel = data['cefr'];
  }

  // Đừng quên dispose các controller để tránh rò rỉ bộ nhớ
  @override
  void dispose() {
    _wordController.dispose();
    _ipaController.dispose();
    _meaningController.dispose();
    _posController.dispose();
    _topicController.dispose();
    _synonymsController.dispose();
    _notesController.dispose();
    _exampleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color lightBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);

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
        title: const Text(
          'Edit Word',
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- CÁC TRƯỜNG NHẬP LIỆU ĐƯỢC ĐIỀN SẴN ---
                  _FormTextField(label: "Word", controller: _wordController),
                  const SizedBox(height: 12),
                  const _AiEnrichButton(),
                  const SizedBox(height: 16),
                  _FormTextField(label: "IPA", controller: _ipaController),
                  const SizedBox(height: 16),
                  _FormTextField(
                    label: "Meaning (Vietnamese)",
                    controller: _meaningController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  _FormTextField(label: "Part of speech", controller: _posController),
                  const SizedBox(height: 16),
                  _buildCefrDropdown(),
                  const SizedBox(height: 16),
                  _FormTextField(label: "Topic", controller: _topicController),
                  const SizedBox(height: 16),
                  _FormTextField(
                    label: "Synonyms",
                    controller: _synonymsController,
                    hint: "framework, form",
                  ),
                  const SizedBox(height: 16),
                  _FormTextField(label: "Notes", controller: _notesController, maxLines: 3),
                  const SizedBox(height: 16),
                  _FormTextField(
                    label: "Example",
                    controller: _exampleController,
                    maxLines: 4,
                    hint: "Data structures and algorithms are...",
                  ),
                  const SizedBox(height: 24),
                  // --- CÁC NÚT HÀNH ĐỘNG ---
                  Row(
                    children: [
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
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Xử lý logic lưu các thay đổi
                            if (_formKey.currentState?.validate() ?? false) {
                              // Nếu form hợp lệ, thực hiện lưu dữ liệu
                              Navigator.of(context).pop(); // Quay lại sau khi lưu
                            }
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

// --- CÁC WIDGET THÀNH PHẦN (TÁI SỬ DỤNG) ---

class _FormTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final int maxLines;
  final TextEditingController controller;

  const _FormTextField({
    required this.label,
    required this.controller,
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
          controller: controller,
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

class _AiEnrichButton extends StatelessWidget {
  const _AiEnrichButton();

  @override
  Widget build(BuildContext context) {
    const Color accentGreen = Color(0xFF66DDAA);
    return ElevatedButton(
      onPressed: () {},
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
