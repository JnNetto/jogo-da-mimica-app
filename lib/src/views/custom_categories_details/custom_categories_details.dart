import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimica_att/src/controllers/words_controller.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/music.dart';
import '../../core/widgets/icon_button.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String categoryName;

  const CategoryDetailScreen({super.key, required this.categoryName});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final WordsController wordsController = WordsController();
  final TextEditingController _textEditingController = TextEditingController();
  List<String> _words = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCategoryWords();
    });
  }

  Future<void> _loadCategoryWords() async {
    List<String>? words =
        await wordsController.getCategoryList(widget.categoryName, context);
    setState(() {
      _words = words ?? [];
    });
  }

  Future<void> _addWord() async {
    String newWord = _textEditingController.text.trim();
    if (newWord.isNotEmpty && !_words.contains(newWord)) {
      await wordsController.addItemToCategory(
          widget.categoryName, newWord, context);
      _textEditingController.clear();
      _loadCategoryWords();
    }
  }

  Future<void> _deleteWord(String word) async {
    await wordsController.deleteItemToCategory(
        widget.categoryName, word, context);
    _loadCategoryWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorsApp.background,
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      widget.categoryName,
                      style: GoogleFonts.girassol(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          textStyle: TextStyle(color: ColorsApp.letters)),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 60, top: 60, left: 60),
                              child: TextField(
                                controller: _textEditingController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  labelText: 'Adicionar palavra',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: GestureDetector(
                                onTap: () {
                                  BackgroundMusicPlayer.loadMusic2();
                                  BackgroundMusicPlayer.playBackgroundMusic(2);
                                  _addWord();
                                },
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ColorsApp.color2),
                                    child: const Center(
                                        child: Icon(
                                      Icons.add,
                                      size: 30,
                                      color: Colors.white,
                                    ))),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Lista de palavras
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, bottom: 15),
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorsApp.color2,
                                borderRadius: BorderRadius.circular(8)),
                            child: ListView.builder(
                              itemCount: _words.length,
                              itemBuilder: (context, index) {
                                final word = _words[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(word,
                                        style: GoogleFonts.girassol(
                                            fontSize: 20,
                                            textStyle: TextStyle(
                                                color: ColorsApp.letters))),
                                    trailing: IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          BackgroundMusicPlayer.loadMusic2();
                                          BackgroundMusicPlayer
                                              .playBackgroundMusic(2);
                                          _deleteWord(word);
                                        }),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backButton(),
            deleteButton(),
            addButton()
          ],
        ),
      ),
    );
  }

  Widget backButton() {
    return Positioned(
        top: 10,
        left: 10,
        child: CustomIconButton(
            elevation: 5,
            buttonColor: ColorsApp.color1,
            onPressed: () async {
              BackgroundMusicPlayer.loadMusic2();
              BackgroundMusicPlayer.playBackgroundMusic(2);
              await wordsController.preloadCategories(context, true);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            icon: Icons.arrow_back,
            padding: 0));
  }

  Widget deleteButton() {
    return Positioned(
      bottom: 10,
      left: 10,
      child: CustomIconButton(
        elevation: 5,
        buttonColor: ColorsApp.color1,
        onPressed: () async {
          BackgroundMusicPlayer.loadMusic2();
          BackgroundMusicPlayer.playBackgroundMusic(2);
          bool? confirmDelete = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: ColorsApp.color1,
                title: Text('Confirmar Exclusão',
                    style: GoogleFonts.girassol(
                        fontSize: 20,
                        textStyle: TextStyle(color: ColorsApp.letters))),
                content: Text('Tem certeza que você deseja apagar a categoria?',
                    style: GoogleFonts.girassol(
                        fontSize: 18,
                        textStyle: TextStyle(color: ColorsApp.letters))),
                actions: [
                  TextButton(
                    child: Text('Cancelar',
                        style: GoogleFonts.girassol(
                            fontSize: 15,
                            textStyle: TextStyle(color: ColorsApp.letters))),
                    onPressed: () {
                      BackgroundMusicPlayer.loadMusic2();
                      BackgroundMusicPlayer.playBackgroundMusic(2);
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: Text('Apagar',
                        style: GoogleFonts.girassol(
                            fontSize: 15,
                            textStyle: TextStyle(color: ColorsApp.letters))),
                    onPressed: () {
                      BackgroundMusicPlayer.loadMusic2();
                      BackgroundMusicPlayer.playBackgroundMusic(2);
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            },
          );

          if (confirmDelete == true) {
            BackgroundMusicPlayer.loadMusic2();
            BackgroundMusicPlayer.playBackgroundMusic(2);
            // ignore: use_build_context_synchronously
            await wordsController.deleteCategory(widget.categoryName, context);
            // ignore: use_build_context_synchronously
            Navigator.pop(context, true);
          }
        },
        icon: Icons.delete,
        padding: 0,
      ),
    );
  }

  Widget addButton() {
    return Positioned(
      bottom: 10,
      left: 70,
      child: CustomIconButton(
        elevation: 5,
        buttonColor: ColorsApp.color1,
        onPressed: () async {
          BackgroundMusicPlayer.loadMusic2();
          BackgroundMusicPlayer.playBackgroundMusic(2);
          await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: ColorsApp.color1,
                title: Text('Importar arquivo',
                    style: GoogleFonts.girassol(
                        fontSize: 20,
                        textStyle: TextStyle(color: ColorsApp.letters))),
                content: Text(
                    'Selecione um arquivo com as palavras separadas por vírgulas (de preferência um arquivo .txt)',
                    style: GoogleFonts.girassol(
                        fontSize: 18,
                        textStyle: TextStyle(color: ColorsApp.letters))),
                actions: [
                  TextButton(
                    child: Text('Cancelar',
                        style: GoogleFonts.girassol(
                            fontSize: 15,
                            textStyle: TextStyle(color: ColorsApp.letters))),
                    onPressed: () {
                      BackgroundMusicPlayer.loadMusic2();
                      BackgroundMusicPlayer.playBackgroundMusic(2);
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Importar',
                        style: GoogleFonts.girassol(
                            fontSize: 15,
                            textStyle: TextStyle(color: ColorsApp.letters))),
                    onPressed: () {
                      BackgroundMusicPlayer.loadMusic2();
                      BackgroundMusicPlayer.playBackgroundMusic(2);
                      Navigator.of(context).pop();
                      pickAndReadFile();
                    },
                  ),
                ],
              );
            },
          );
        },
        icon: Icons.import_export,
        padding: 0,
      ),
    );
  }

  String? fileContent;
  List<String>? words;

  Future<void> pickAndReadFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt'],
      );
      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);

        // Lê o conteúdo do arquivo
        String content = await file.readAsString();

        // Processa as palavras separadas por vírgulas
        List<String> parsedWords = content.split(',');

        setState(() {
          fileContent = content;
          words = parsedWords.map((word) => word.trim()).toList();
        });

        for (var i in words!) {
          _textEditingController.text = i;
          _addWord();
          _textEditingController.clear();
        }
        _loadCategoryWords();
      }
    } catch (e) {
      setState(() {
        fileContent = 'Erro ao ler o arquivo: $e';
      });
    }
  }
}
