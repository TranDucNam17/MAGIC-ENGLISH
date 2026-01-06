import 'package:btl_magicenglish/core/api/api_services.dart';
import 'package:btl_magicenglish/features/dashboard/presentation/pages/home_dashboard_page.dart';
import 'package:btl_magicenglish/features/vocab/presentation/pages/view_word_detail_page.dart';
import 'package:flutter/material.dart';
import 'add_word_page.dart';
import 'edit_word_page.dart';
import 'filter_option_page.dart';

class MagicVocabScreen extends StatefulWidget {
  const MagicVocabScreen({super.key});

  @override
  State<MagicVocabScreen> createState() => _MagicVocabScreenState();
}

class _MagicVocabScreenState extends State<MagicVocabScreen> {
  List<dynamic> wordsList = [];
  List<dynamic> filteredWordsList = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';
  String searchQuery = '';
  String cefrFilter = 'All';
  String posFilter = 'All';
  List<String> selectedCefrLevels = [];
  List<String> selectedPosList = [];
  String sortByValue = 'A - Z';
  bool filterAiGenerated = false;
  bool filterUserAdded = false;
  int currentPage = 1;
  int pageSize = 10;

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  Future<void> _loadWords() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final result = await WordApiService.getWords(
        limit: pageSize,
        page: currentPage,
        search: searchQuery.isNotEmpty ? searchQuery : null,
      );

      print('API Response: $result');
      print('Response type: ${result.runtimeType}');

      if (mounted) {
        setState(() {
          // Handle API response - check different possible structures
          List<dynamic> data = [];

          // Check if response has 'data' key with nested structure
          if (result.containsKey('data')) {
            final dataField = result['data'];
            if (dataField is Map<String, dynamic> &&
                dataField.containsKey('data')) {
              // Structure: {success: true, data: {data: [...], ...pagination...}}
              data = (dataField['data'] as List?) ?? [];
            } else if (dataField is List) {
              // Structure: {success: true, data: [...]}
              data = dataField;
            }
          } else if (result.containsKey('words')) {
            // Alternative structure: {success: true, words: [...]}
            data = (result['words'] as List?) ?? [];
          }

          print('Parsed data: $data');
          print('Data length: ${data.length}');
          if (data.isNotEmpty) {
            print('First item: ${data.first}');
            print('First item keys: ${(data.first as Map).keys.toList()}');
          }
          wordsList = data;
          _applyFilters();
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        print('Error loading words: $e');
        setState(() {
          hasError = true;
          errorMessage = e.toString();
          isLoading = false;
        });
      }
    }
  }

  /// Normalize POS values from API to match filter abbreviations
  String _normalizePosValue(String posValue) {
    final normalized = posValue.toLowerCase().trim();
    // Map full words to abbreviations used in filter
    const posMap = {
      'adjective': 'adj',
      'adverb': 'adv',
      'preposition': 'prep',
      'conjunction': 'conj',
      'pronoun': 'pronoun',
      'noun': 'noun',
      'verb': 'verb',
    };
    return posMap[normalized] ?? normalized;
  }

  void _applyFilters() {
    setState(() {
      print('========== FILTER DEBUG ==========');
      print('Total words in list: ${wordsList.length}');
      if (wordsList.isNotEmpty) {
        print('First word: ${wordsList.first}');
        print('First word keys: ${wordsList.first.keys.toList()}');
      }
      print('Selected CEFR levels: $selectedCefrLevels');
      print('Selected POS: $selectedPosList');
      print('Sort by: $sortByValue');
      print('Filter AI: $filterAiGenerated, Filter User: $filterUserAdded');
      print('Search query: "$searchQuery"');
      print('==================================');

      // Filter by search query, CEFR levels, POS, and source
      filteredWordsList = wordsList.where((word) {
        final term = (word['term'] ?? '').toString().toLowerCase();
        final cefr = word['cefr'] ?? '';
        final pos = _normalizePosValue(word['pos'] ?? '');
        final source = word['source'] ?? 'user'; // 'ai' or 'user'

        // Search filter
        final matchSearch =
            searchQuery.isEmpty || term.contains(searchQuery.toLowerCase());

        // CEFR filter
        final matchCefr =
            selectedCefrLevels.isEmpty || selectedCefrLevels.contains(cefr);

        // POS filter - compare with normalized POS
        final matchPos =
            selectedPosList.isEmpty || selectedPosList.contains(pos);

        // Source filter
        final isAiGenerated = source.toLowerCase() == 'ai';
        bool matchSource = true;
        // Only apply source filter if at least one source is selected
        if (filterAiGenerated || filterUserAdded) {
          matchSource =
              (filterAiGenerated && isAiGenerated) ||
              (filterUserAdded && !isAiGenerated);
        }
        // If no source filter is selected, show all

        final matches = matchSearch && matchCefr && matchPos && matchSource;

        // Log each word and why it's filtered
        if (!matches) {
          print(
            'EXCLUDED: "$term" | cefr:$cefr(match:$matchCefr) pos:$pos(available:$selectedPosList match:$matchPos) source:$source(match:$matchSource) search:$matchSearch',
          );
        } else if (selectedPosList.isNotEmpty && selectedCefrLevels.isEmpty) {
          // Debug: show which words PASS when only POS filter is set
          print('INCLUDED: "$term" | pos:$pos(match:$matchPos)');
        }

        return matches;
      }).toList();

      print('Result: ${filteredWordsList.length} words matched');
      print('==================================');

      // Apply sorting
      if (sortByValue == 'A - Z') {
        filteredWordsList.sort(
          (a, b) => (a['term'] ?? '').toString().compareTo(
            (b['term'] ?? '').toString(),
          ),
        );
      } else if (sortByValue == 'Z - A') {
        filteredWordsList.sort(
          (a, b) => (b['term'] ?? '').toString().compareTo(
            (a['term'] ?? '').toString(),
          ),
        );
      } else if (sortByValue == 'Newest') {
        filteredWordsList.sort((a, b) {
          final dateA =
              DateTime.tryParse(a['created_at'] ?? '') ?? DateTime(1970);
          final dateB =
              DateTime.tryParse(b['created_at'] ?? '') ?? DateTime(1970);
          return dateB.compareTo(dateA);
        });
      } else if (sortByValue == 'Oldest') {
        filteredWordsList.sort((a, b) {
          final dateA =
              DateTime.tryParse(a['created_at'] ?? '') ?? DateTime(1970);
          final dateB =
              DateTime.tryParse(b['created_at'] ?? '') ?? DateTime(1970);
          return dateA.compareTo(dateB);
        });
      }
    });
  }

  void _onSearch(String query) {
    setState(() {
      searchQuery = query;
      currentPage = 1;
    });
    _applyFilters();
  }

  void _onRefresh() {
    setState(() => currentPage = 1);
    _loadWords();
  }

  @override
  Widget build(BuildContext context) {
    const Color lightBlueBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);

    return Scaffold(
      backgroundColor: lightBlueBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.grey.withOpacity(0.2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkText),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeDashboardScreen(),
            ),
          ),
        ),
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
            SearchFilterAddSection(
              onSearch: _onSearch,
              onRefresh: _onRefresh,
              onApplyFilter: (cefrLevels, posList, sortBy, aiGen, userAdded) {
                print('========== ON APPLY FILTER ==========');
                print(
                  'Received CEFR: $cefrLevels (length: ${cefrLevels.length})',
                );
                print('Received POS: $posList (length: ${posList.length})');
                if (posList.isNotEmpty) {
                  print('POS values: ${posList.map((p) => '"$p"').join(', ')}');
                }
                print('Received Sort: $sortBy');
                print('Received AI: $aiGen, User: $userAdded');
                print('=====================================');
                setState(() {
                  selectedCefrLevels = cefrLevels;
                  selectedPosList = posList;
                  sortByValue = sortBy;
                  filterAiGenerated = aiGen;
                  filterUserAdded = userAdded;
                });
                _applyFilters();
              },
            ),
            // Error State
            if (hasError)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 8),
                    Text('Error: $errorMessage'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _loadWords,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
            else if (isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (filteredWordsList.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox, size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No words found',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: filteredWordsList.length,
                  itemBuilder: (context, index) {
                    final item = filteredWordsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: VocabularyCard(
                        vocabData: item,
                        onRefresh: _onRefresh,
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

class SearchFilterAddSection extends StatefulWidget {
  final Function(String) onSearch;
  final VoidCallback onRefresh;
  final Function(List<String>, List<String>, String, bool, bool)? onApplyFilter;

  const SearchFilterAddSection({
    super.key,
    required this.onSearch,
    required this.onRefresh,
    this.onApplyFilter,
  });

  @override
  State<SearchFilterAddSection> createState() => _SearchFilterAddSectionState();
}

class _SearchFilterAddSectionState extends State<SearchFilterAddSection> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => widget.onSearch(value),
                  decoration: InputDecoration(
                    hintText: "Search word",
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () async {
                  final filterData =
                      await Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => const FilterOptionScreen(),
                        ),
                      );
                  if (filterData != null) {
                    // Safely extract filter values with proper casting
                    final cefrData = filterData['cefrLevels'];
                    final cefrList = cefrData is List
                        ? List<String>.from(cefrData.map((e) => e.toString()))
                        : <String>[];

                    final posData = filterData['posFilters'];
                    final posList = posData is List
                        ? List<String>.from(posData.map((e) => e.toString()))
                        : <String>[];

                    final sortByValue =
                        filterData['sortBy']?.toString() ?? 'A - Z';

                    bool filterAiGenerated = false;
                    bool filterUserAdded = false;
                    final sourceData = filterData['source'];
                    if (sourceData is Map) {
                      filterAiGenerated =
                          sourceData['aiGenerated'] as bool? ?? false;
                      filterUserAdded =
                          sourceData['userAdded'] as bool? ?? false;
                    }

                    // Call parent callback to update state
                    widget.onApplyFilter?.call(
                      cefrList,
                      posList,
                      sortByValue,
                      filterAiGenerated,
                      filterUserAdded,
                    );
                  }
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
          // Add Button & Refresh Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tooltip(
                message: 'Refresh',
                child: IconButton(
                  onPressed: widget.onRefresh,
                  icon: const Icon(Icons.refresh),
                  color: const Color(0xFF0D47A1),
                ),
              ),
              SizedBox(
                width: 48,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(
                          MaterialPageRoute(
                            builder: (context) => const AddWordScreen(),
                          ),
                        )
                        .then((_) => widget.onRefresh());
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
            ],
          ),
        ],
      ),
    );
  }
}

class VocabularyCard extends StatelessWidget {
  final dynamic vocabData;
  final VoidCallback onRefresh;

  const VocabularyCard({
    super.key,
    required this.vocabData,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color accentPurple = Color(0xFF673AB7);

    // Handle both Map and dynamic data from API
    final String word = vocabData['term'] ?? vocabData['word'] ?? 'N/A';
    final String ipa = vocabData['ipa'] ?? '';
    final String meaning = vocabData['note'] ?? vocabData['meaning'] ?? '';
    final int id = vocabData['id'] ?? 0;

    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        word,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (ipa.isNotEmpty)
                        Text(
                          ipa,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (meaning.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                "Note: $meaning",
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ViewWordDetailScreen(wordData: vocabData),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentPurple.withOpacity(0.8),
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("View"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(
                          MaterialPageRoute(
                            builder: (context) =>
                                EditWordScreen(wordData: vocabData),
                            fullscreenDialog: true,
                          ),
                        )
                        .then((_) => onRefresh());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Edit"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    _showDeleteConfirmation(context, word, id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String word, int id) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Word'),
          content: Text(
            'Are you sure you want to delete "$word"? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await _deleteWord(context, id);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteWord(BuildContext context, int id) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final result = await WordApiService.deleteWord(id);
      if (result['success'] == true) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Word deleted successfully')),
        );
        onRefresh();
      } else {
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error: ${result['error']}')),
        );
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Error deleting word: $e')),
      );
    }
  }
}
