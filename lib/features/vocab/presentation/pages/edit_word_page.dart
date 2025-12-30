import 'package:btl_magicenglish/core/api/api_services.dart';
import 'package:flutter/material.dart';

class EditWordScreen extends StatefulWidget {
  final dynamic wordData;

  const EditWordScreen({super.key, required this.wordData});

  @override
  State<EditWordScreen> createState() => _EditWordScreenState();
}

class _EditWordScreenState extends State<EditWordScreen> {
  late final TextEditingController _termController;
  late final TextEditingController _ipaController;
  late final TextEditingController _noteController;
  late final TextEditingController _posController;
  late final TextEditingController _exampleEnController;
  late final TextEditingController _exampleViController;
  late final TextEditingController _cefrController;

  bool isLoading = false;
  String? errorMessage;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final data = widget.wordData;
    _termController = TextEditingController(
      text: data['term'] ?? data['word'] ?? '',
    );
    _ipaController = TextEditingController(text: data['ipa'] ?? '');
    _noteController = TextEditingController(
      text: data['note'] ?? data['meaning'] ?? '',
    );
    _posController = TextEditingController(
      text: data['pos'] ?? data['partOfSpeech'] ?? '',
    );
    _exampleEnController = TextEditingController(
      text: data['example_en'] ?? data['example'] ?? '',
    );
    _exampleViController = TextEditingController(
      text: data['example_vi'] ?? '',
    );
    _cefrController = TextEditingController(text: data['cefr'] ?? 'B1');
  }

  @override
  void dispose() {
    _termController.dispose();
    _ipaController.dispose();
    _noteController.dispose();
    _posController.dispose();
    _exampleEnController.dispose();
    _exampleViController.dispose();
    _cefrController.dispose();
    super.dispose();
  }

  Future<void> _updateWord() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final wordId = widget.wordData['id'];
    if (wordId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error: Word ID not found')));
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await WordApiService.updateWord(
        id: wordId,
        term: _termController.text,
        ipa: _ipaController.text,
        note: _noteController.text,
        pos: _posController.text,
        exampleEn: _exampleEnController.text,
        exampleVi: _exampleViController.text,
        cefr: _cefrController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Word updated successfully')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() => errorMessage = e.toString());
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
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
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (errorMessage != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  _FormTextField(label: "Term", controller: _termController),
                  const SizedBox(height: 16),
                  _FormTextField(label: "IPA", controller: _ipaController),
                  const SizedBox(height: 16),
                  _FormTextField(
                    label: "Note",
                    controller: _noteController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  _FormTextField(
                    label: "Part of speech",
                    controller: _posController,
                  ),
                  const SizedBox(height: 16),
                  _FormTextField(
                    label: "Example (English)",
                    controller: _exampleEnController,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  _FormTextField(
                    label: "Example (Vietnamese)",
                    controller: _exampleViController,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  _FormCefrDropdown(controller: _cefrController),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: isLoading
                              ? null
                              : () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primaryBlue,
                            side: const BorderSide(
                              color: primaryBlue,
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
                          onPressed: isLoading ? null : _updateWord,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  "Save",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
          style: const TextStyle(
            color: Color(0xFF616161),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'This field is required';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
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

class _FormCefrDropdown extends StatefulWidget {
  final TextEditingController controller;

  const _FormCefrDropdown({required this.controller});

  @override
  State<_FormCefrDropdown> createState() => _FormCefrDropdownState();
}

class _FormCefrDropdownState extends State<_FormCefrDropdown> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.controller.text.isEmpty ? 'B1' : widget.controller.text;
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CEFR Level',
          style: TextStyle(
            color: Color(0xFF616161),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: _selectedValue,
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedValue = value);
              widget.controller.text = value;
            }
          },
          items: const ['A1', 'A2', 'B1', 'B2', 'C1', 'C2']
              .map((level) => DropdownMenuItem(
                value: level,
                child: Text(
                  level,
                  style: const TextStyle(fontSize: 14),
                ),
              ))
              .toList(),
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
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: primaryBlue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

