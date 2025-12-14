
import 'package:btl_magicenglish/features/vocab/presentation/pages/view_word_detail_page.dart';
import 'package:flutter/material.dart';

import 'add_word_page.dart';
import 'edit_word_page.dart';
import 'filter_option_page.dart';

// MagicVocab screen
class MagicVocabScreen extends StatefulWidget {
  const MagicVocabScreen({super.key});

  @override
  State<MagicVocabScreen> createState() => _MagicVocabScreenState();
}

class _MagicVocabScreenState extends State<MagicVocabScreen> {
  // Tab "Vocab" được chọn
  final int _selectedIndex = 1;

  // Dữ liệu giả cho danh sách từ vựng
  final List<Map<String, String>> vocabList = [
    {
      "word": "structure", "ipa": "/ˈstrʌk.tʃər/", "meaning": "Framework", "cefr": "B2"
    },
    {
      "word": "serendipity", "ipa": "/ˌser.ənˈdɪp.ə.ti/", "meaning": "Finding good things without looking", "cefr": "C1"
    },
    {
      "word": "ubiquitous", "ipa": "/juːˈbɪk.wə.təs/", "meaning": "Present, appearing, or found everywhere", "cefr": "C1"
    },
    {
      "word": "ephemeral", "ipa": "/əˈfem.ər.əl/", "meaning": "Lasting for a very short time", "cefr": "B2"
    },
    {
      "word": "book", "ipa": "/bʊk/", "meaning": "A written or printed work", "cefr": "A1"
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color lightBlueBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);

    return Scaffold(
      backgroundColor: lightBlueBackground,
      // 1. AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.grey.withOpacity(0.2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),

        // automaticallyImplyLeading: false,

        title: const Text(
          'Magic Vocab',
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 2. Search, Filter and Add Section
            const SearchFilterAddSection(),

            // 3. Vocabulary List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: vocabList.length,
                itemBuilder: (context, index) {
                  // lấy đô tượng Map ra
                  final item = vocabList[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: VocabularyCard(
                      vocabData: item,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// các widget thành phần

// 2. Search, Filter and Add Section
class SearchFilterAddSection extends StatelessWidget {
  const SearchFilterAddSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              // Search Field
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search word",
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Filter Button
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(
                      context,
                      rootNavigator: true).push(MaterialPageRoute(builder: (context) => const FilterOptionScreen()));
                },
                icon: const Icon(Icons.filter_list),
                label: const Text("Filter"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0D47A1),
                  side: const BorderSide(color: Color(0xFF0D47A1)),
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Add Button
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 48,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (context) => const AddWordScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 3. Vocabulary Card
class VocabularyCard extends StatelessWidget {
  final Map<String, String> vocabData;

  const VocabularyCard({
    super.key,
    required this.vocabData,
  });


  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color accentPurple = Color(0xFF673AB7);

    // lấy dữ liệu từ Map 'vocabData'
    // sử dụng '??' để cung cấp giá trị mặc định, tránh null
    final String word = vocabData['word'] ?? 'N/A';
    final String ipa = vocabData['ipa'] ?? '';
    final String meaning = vocabData['meaning'] ?? '';
    final String cefrLevel = vocabData['cefr'] ?? 'N/A';

    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Word, IPA, and CEFR Level
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(word, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(ipa, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    cefrLevel,
                    style: const TextStyle(color: primaryBlue, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Middle: Meaning
            Text("Meaning: $meaning", style: TextStyle(fontSize: 14, color: Colors.grey[800])),
            const SizedBox(height: 12),
            // Bottom Row: Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => ViewWordDetailScreen(wordData: vocabData),
                          fullscreenDialog: true)
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentPurple.withOpacity(0.8),
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  child: const Text("View"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => EditWordScreen(wordData: vocabData,),
                          fullscreenDialog: true)
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  child: const Text("Edit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
