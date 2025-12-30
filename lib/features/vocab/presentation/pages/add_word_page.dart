import 'package:btl_magicenglish/core/api/api_services.dart';
import 'package:flutter/material.dart';

class AddWordScreen extends StatefulWidget {
  const AddWordScreen({super.key});

  @override
  State<AddWordScreen> createState() => _AddWordScreenState();
}

class _AddWordScreenState extends State<AddWordScreen> {
  bool isLoading = false;
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();

  bool _isEnriching = false;

  final _termController = TextEditingController();
  final _ipaController = TextEditingController();
  final _noteController = TextEditingController();
  final _posController = TextEditingController();
  final _exampleEnController = TextEditingController();
  final _exampleViController = TextEditingController();
  final _cefrController = TextEditingController(text: 'B1');

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

  Future<void> _createWord() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await WordApiService.createWord(
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
          const SnackBar(content: Text('Word created successfully')),
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

  Future<void> _handleAiEnrich() async {
    FocusScope.of(context).unfocus();
    final term = _termController.text.trim();
    if (term.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a Term to enrich.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    setState(() {
      _isEnriching = true;
      errorMessage = null;
    });
    try {
      print('[AddWordScreen] Starting AI enrich for term: $term');
      final result = await AiApiService.enrichWord({'term': term});
      print('[AddWordScreen] AI enrich response: $result');
      print('[AddWordScreen] Response type: ${result.runtimeType}');
      
      if (result['success'] == true && result['data'] != null) {
        final enrichedData = result['data'] as Map<String, dynamic>;
        print('[AddWordScreen] Enriched data: $enrichedData');
        setState(() {
          _ipaController.text = enrichedData['ipa']?.toString() ?? '';
          _posController.text = enrichedData['pos']?.toString() ?? '';
          _noteController.text = enrichedData['note']?.toString() ?? '';
          _exampleEnController.text =
              enrichedData['example_en']?.toString() ?? '';
          _exampleViController.text =
              enrichedData['example_vi']?.toString() ?? '';
          _cefrController.text = enrichedData['cefr']?.toString() ?? 'B1';
        });
        print('[AddWordScreen] AI enrichment successful!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('AI enrichment successful!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        final errorMsg = result['error'] ?? result['message'] ?? 'Failed to get data from AI service.';
        print('[AddWordScreen] AI enrich failed: $errorMsg');
        throw Exception(errorMsg);
      }
    } catch (e) {
      print('[AddWordScreen] Exception in AI enrich: $e');
      if (mounted) {
        setState(
          () => errorMessage = e.toString().replaceFirst('Exception: ', ''),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('AI Enrich Failed: ${errorMessage!}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isEnriching = false);
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
          'Add Word',
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
                  const _AiEnrichButton(),
                  _FormTextField(
                    label: "Term",
                    controller: _termController,
                    suffixIcon: _isEnriching
                        ? const Padding(
                            padding: EdgeInsets.only(right: 12.0),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : Tooltip(
                            message: 'AI Enrich',
                            child: IconButton(
                              onPressed: _handleAiEnrich,
                              icon: const Icon(
                                Icons.auto_awesome,
                                color: Color(0xFF673AB7),
                              ),
                            ),
                          ),
                  ),
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
                          onPressed: isLoading ? null : _createWord,
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
                                  "Create",
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
          Text("AI Enrich", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _FormTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final int maxLines;
  final TextEditingController controller;
  final Widget? suffixIcon;

  const _FormTextField({
    required this.label,
    required this.controller,
    this.hint,
    this.maxLines = 1,
    this.suffixIcon,
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
            suffixIcon: suffixIcon,
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
    _selectedValue = widget.controller.text.isEmpty
        ? 'B1'
        : widget.controller.text;
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
              .map(
                (level) => DropdownMenuItem(
                  value: level,
                  child: Text(level, style: const TextStyle(fontSize: 14)),
                ),
              )
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
              borderSide: const BorderSide(color: primaryBlue),
            ),
          ),
        ),
      ],
    );
  }
}
