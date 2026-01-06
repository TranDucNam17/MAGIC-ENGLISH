import 'package:flutter/material.dart';

class GrammarTipsExamplesScreen extends StatelessWidget {
  const GrammarTipsExamplesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color lightBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);
    const Color primaryBlue = Color(0xFF0D47A1);

    final tips = [
      {
        'title': 'Subject-Verb Agreement',
        'description': 'The subject and verb must agree in number',
        'examples': [
          {
            'wrong': 'The group are meeting tomorrow',
            'correct': 'The group is meeting tomorrow',
            'explanation':
                '"Group" is a singular noun, so use "is" instead of "are"',
          },
          {
            'wrong': 'She don\'t like coffee',
            'correct': 'She doesn\'t like coffee',
            'explanation':
                'For third person singular, use "doesn\'t" not "don\'t"',
          },
        ],
      },
      {
        'title': 'Tense Consistency',
        'description': 'Keep the same tense throughout your writing',
        'examples': [
          {
            'wrong': 'I went to the store and buy milk',
            'correct': 'I went to the store and bought milk',
            'explanation': 'Both verbs should be in past tense',
          },
          {
            'wrong': 'She was working and is tired',
            'correct': 'She was working and was tired',
            'explanation': 'Both actions occurred at the same time in the past',
          },
        ],
      },
      {
        'title': 'Article Usage (A/An/The)',
        'description': 'Use correct articles to specify or generalize nouns',
        'examples': [
          {
            'wrong': 'I have apple and banana',
            'correct': 'I have an apple and a banana',
            'explanation':
                '"Apple" starts with a vowel sound (use "an"), "banana" needs "a"',
          },
          {
            'wrong': 'Sun is bright today',
            'correct': 'The sun is bright today',
            'explanation': 'Use "the" for unique, specific items',
          },
        ],
      },
      {
        'title': 'Comma Rules',
        'description': 'Use commas to separate clauses and items in a list',
        'examples': [
          {
            'wrong': 'I like apples oranges and bananas',
            'correct': 'I like apples, oranges, and bananas',
            'explanation': 'Use commas to separate items in a list',
          },
          {
            'wrong': 'Although it was raining we went for a walk',
            'correct': 'Although it was raining, we went for a walk',
            'explanation':
                'Use a comma after an introductory clause (Oxford comma)',
          },
        ],
      },
      {
        'title': 'Preposition Usage',
        'description': 'Use the correct preposition to show relationships',
        'examples': [
          {
            'wrong': 'I am interested in learning English',
            'correct': 'I am interested in learning English',
            'explanation': 'Use "in" with "interested" to show the focus',
          },
          {
            'wrong': 'She is different than her brother',
            'correct': 'She is different from her brother',
            'explanation': 'Use "from" for comparisons with adjectives',
          },
        ],
      },
    ];

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
          'AI Tips & Examples',
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: primaryBlue.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: primaryBlue, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Common grammar mistakes and how to fix them',
                        style: TextStyle(
                          color: primaryBlue,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tips list
              ...List.generate(tips.length, (index) {
                final tip = tips[index];
                return _TipCard(
                  title: tip['title']! as String,
                  description: tip['description']! as String,
                  examples: (tip['examples'] as List)
                      .cast<Map<String, String>>(),
                  index: index,
                );
              }),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _TipCard extends StatefulWidget {
  final String title;
  final String description;
  final List<Map<String, String>> examples;
  final int index;

  const _TipCard({
    required this.title,
    required this.description,
    required this.examples,
    required this.index,
  });

  @override
  State<_TipCard> createState() => _TipCardState();
}

class _TipCardState extends State<_TipCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2.0,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Column(
        children: [
          // Header
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${widget.index + 1}',
                          style: const TextStyle(
                            color: primaryBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF1A252F),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      _expanded ? Icons.expand_less : Icons.expand_more,
                      color: primaryBlue,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Examples (when expanded)
          if (_expanded) ...[
            Divider(height: 1, color: Colors.grey[300]),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.examples.length, (exIndex) {
                  final example = widget.examples[exIndex];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: exIndex < widget.examples.length - 1 ? 16.0 : 0,
                    ),
                    child: _ExampleItem(
                      wrong: example['wrong']!,
                      correct: example['correct']!,
                      explanation: example['explanation']!,
                    ),
                  );
                }),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ExampleItem extends StatelessWidget {
  final String wrong;
  final String correct;
  final String explanation;

  const _ExampleItem({
    required this.wrong,
    required this.correct,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Wrong example
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.close, color: Colors.red.shade600, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  wrong,
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Correct example
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.check, color: Colors.green.shade600, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  correct,
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Explanation
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade600, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  explanation,
                  style: TextStyle(color: Colors.blue.shade700, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
