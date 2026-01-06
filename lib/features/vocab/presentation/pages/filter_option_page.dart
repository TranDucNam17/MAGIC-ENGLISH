import 'package:flutter/material.dart';

class FilterOptionScreen extends StatefulWidget {
  const FilterOptionScreen({super.key});

  @override
  State<FilterOptionScreen> createState() => _FilterOptionScreenState();
}

class _FilterOptionScreenState extends State<FilterOptionScreen> {
  final Set<String> _selectedCefrLevels = {};
  final Set<String> _selectedPos = {};
  String _sortByValue = "A - Z";
  String _topicValue = "AI Generate";
  bool _isAiGenerated = false;
  bool _isUserAdded = false;

  void _resetFilters() {
    setState(() {
      _selectedCefrLevels.clear();
      _selectedPos.clear();
      _sortByValue = "A - Z";
      _topicValue = "AI Generate";
      _isAiGenerated = false;
      _isUserAdded = false;
    });
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
          icon: const Icon(Icons.arrow_back, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Filter Option',
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _SectionTitle(title: "CEFR Levels"),
                      const SizedBox(height: 8),
                      _buildCefrChips(),
                      const SizedBox(height: 16),

                      const _SectionTitle(title: "Part of Speech"),
                      const SizedBox(height: 8),
                      _buildPosChips(),
                      const SizedBox(height: 16),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildSortBySection()),
                          const SizedBox(width: 16),
                          Expanded(child: _buildTopicSection()),
                        ],
                      ),
                      const SizedBox(height: 16),

                      const _SectionTitle(title: "Source"),
                      const SizedBox(height: 8),
                      _buildSourceSection(),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _resetFilters,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryBlue,
                        side: const BorderSide(color: primaryBlue, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Reset",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Return filter data
                        Navigator.of(context).pop({
                          'cefrLevels': _selectedCefrLevels.toList(),
                          'posFilters': _selectedPos.toList(),
                          'sortBy': _sortByValue,
                          'source': {
                            'aiGenerated': _isAiGenerated,
                            'userAdded': _isUserAdded,
                          },
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Apply Filter",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCefrChips() {
    final Map<String, Color> cefrColors = {
      'A1': Colors.green.shade300,
      'A2': Colors.green.shade400,
      'B1': Colors.blue.shade300,
      'B2': Colors.blue.shade400,
      'C1': Colors.purple.shade300,
      'C2': Colors.purple.shade400,
    };

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: cefrColors.keys.map((level) {
        final bool isSelected = _selectedCefrLevels.contains(level);
        return ChoiceChip(
          label: Text(level),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedCefrLevels.add(level);
              } else {
                _selectedCefrLevels.remove(level);
              }
            });
          },
          selectedColor: cefrColors[level],
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : cefrColors[level],
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.white,
          shape: const StadiumBorder(),
          side: isSelected ? BorderSide.none : BorderSide(color: cefrColors[level]!),
        );
      }).toList(),
    );
  }

  Widget _buildPosChips() {
    final Map<String, Color> posColors = {
      'noun': Colors.blue.shade400,
      'verb': Colors.green.shade400,
      'adj': Colors.orange.shade400,
      'adv': Colors.purple.shade400,
      'prep': Colors.teal.shade400,
      'pronoun': Colors.pink.shade300,
      'conj': Colors.grey.shade500,
    };

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: posColors.keys.map((pos) {
        final bool isSelected = _selectedPos.contains(pos);
        return FilterChip(
          label: Text(pos),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedPos.add(pos);
              } else {
                _selectedPos.remove(pos);
              }
            });
          },
          selectedColor: posColors[pos],
          checkmarkColor: Colors.white,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : posColors[pos],
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.white,
          shape: const StadiumBorder(),
          side: isSelected ? BorderSide.none : BorderSide(color: posColors[pos]!),
        );
      }).toList(),
    );
  }

  Widget _buildSortBySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: "Sort by"),
        const SizedBox(height: 8),
        _buildRadioTile("A - Z", _sortByValue, (val) => setState(() => _sortByValue = val)),
        _buildRadioTile("Z - A", _sortByValue, (val) => setState(() => _sortByValue = val)),
        _buildRadioTile("Newest", _sortByValue, (val) => setState(() => _sortByValue = val)),
        _buildRadioTile("Oldest", _sortByValue, (val) => setState(() => _sortByValue = val)),
      ],
    );
  }

  Widget _buildTopicSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: "Topic"),
        const SizedBox(height: 8),
        _buildRadioTile("AI Generate", _topicValue, (val) => setState(() => _topicValue = val)),
      ],
    );
  }

  Widget _buildRadioTile(String title, String groupValue, Function(String) onChanged) {
    return SizedBox(
      height: 36,
      child: RadioListTile<String>(
        title: Text(title, style: TextStyle(fontSize: 14)),
        value: title,
        groupValue: groupValue,
        onChanged: (value) => onChanged(value!),
        contentPadding: EdgeInsets.zero,
        activeColor: const Color(0xFF0D47A1),
      ),
    );
  }

  Widget _buildSourceSection() {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text("AI generated"),
          value: _isAiGenerated,
          onChanged: (bool? value) {
            setState(() {
              _isAiGenerated = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          activeColor: const Color(0xFF0D47A1),
        ),
        CheckboxListTile(
          title: const Text("User added"),
          value: _isUserAdded,
          onChanged: (bool? value) {
            setState(() {
              _isUserAdded = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          activeColor: const Color(0xFF0D47A1),
        ),
      ],
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
