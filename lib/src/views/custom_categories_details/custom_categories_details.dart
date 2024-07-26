import 'package:flutter/material.dart';

import '../../database/lists_database.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String categoryName;

  const CategoryDetailScreen({Key? key, required this.categoryName})
      : super(key: key);

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final ListsDatabase _listsDatabase = ListsDatabase();
  final TextEditingController _textEditingController = TextEditingController();
  List<String> _words = [];

  @override
  void initState() {
    super.initState();
    _loadCategoryWords();
  }

  Future<void> _loadCategoryWords() async {
    List<String>? words =
        await _listsDatabase.getCategoryList(widget.categoryName);
    setState(() {
      _words = words ?? [];
    });
  }

  Future<void> _addWord() async {
    String newWord = _textEditingController.text.trim();
    if (newWord.isNotEmpty && !_words.contains(newWord)) {
      await _listsDatabase.addItemToCategory(widget.categoryName, newWord);
      _textEditingController.clear();
      _loadCategoryWords(); // Recarrega as palavras para atualizar a lista
    }
  }

  Future<void> _deleteWord(String word) async {
    await _listsDatabase.deleteItemToCategory(widget.categoryName, word);
    _loadCategoryWords(); // Recarrega as palavras para atualizar a lista
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      labelText: 'Adicionar palavra',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addWord,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _words.length,
                itemBuilder: (context, index) {
                  final word = _words[index];
                  return ListTile(
                    title: Text(word),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteWord(word),
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
