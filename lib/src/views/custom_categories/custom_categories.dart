import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimica_att/src/database/lists_database.dart';
import 'package:mimica_att/src/views/custom_categories_details/custom_categories_details.dart';
import '../../controllers/words_controller.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/music.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/icon_button.dart';
import '../gameScreen/game_screen.dart';

class CustomCategories extends StatefulWidget {
  const CustomCategories({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomCategoriesState createState() => _CustomCategoriesState();
}

class _CustomCategoriesState extends State<CustomCategories> {
  List<String> selectedCategory = [];
  int timeInSeconds = 60;
  Map<String, double> buttonElevations = {};
  Map<String, Color> buttonColor = {};
  List<String> categories = [];
  late Map<String, List<String>> customCategories;
  final WordsController _wordsController = WordsController();

  final ListsDatabase listsDatabase = ListsDatabase();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeDatabase();
      _loadCategories();
    });
  }

  Future<void> _initializeDatabase() async {
    await listsDatabase.initHive();
  }

  Future<void> _loadCategories() async {
    customCategories = await _wordsController.preloadCategories(context, true);
    List<String> newCategories =
        await _wordsController.getTitleCategories(context);
    setState(() {
      categories = newCategories;
      for (var category in categories) {
        buttonColor[category] = ColorsApp.color1;
        buttonElevations[category] = 10.0;
      }
    });
  }

  Future<void> addNewCategory() async {
    TextEditingController textFieldController = TextEditingController();
    String newCategory = "";

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(
              'Adicionar Nova Lista',
              style: TextStyle(color: ColorsApp.letters),
            ),
            backgroundColor: ColorsApp.color1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: textFieldController,
                    style: TextStyle(color: ColorsApp.letters),
                    decoration: InputDecoration(
                      hintText: "Digite o nome da nova lista",
                      hintStyle: TextStyle(color: ColorsApp.color4),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: ColorsApp.letters),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Adicionar',
                  style: TextStyle(color: ColorsApp.letters),
                ),
                onPressed: () async {
                  newCategory = textFieldController.text.trim();
                  if (newCategory.isNotEmpty &&
                      !categories.contains(newCategory)) {
                    await _wordsController.addCategory(newCategory, context);
                    setState(() {
                      categories.add(newCategory);
                      buttonColor[newCategory] = ColorsApp.color1;
                      buttonElevations[newCategory] = 10.0;
                    });
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Nome inválido ou já existente."),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }

  void _toggleElevation(String category) {
    setState(() {
      if (buttonElevations[category] == 0) {
        buttonElevations[category] = 10.0;
        buttonColor[category] = ColorsApp.color1;
      } else {
        buttonElevations[category] = 0;
        buttonColor[category] = ColorsApp.color3;
      }
    });
  }

  void _selectedsCategories(String category) {
    setState(() {
      if (buttonElevations[category] == 0) {
        selectedCategory.add(category);
      } else {
        selectedCategory.remove(category);
      }
    });
  }

  void _navigateToCategoryDetail(String category) async {
    final bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailScreen(categoryName: category),
      ),
    );

    if (result == true) {
      _loadCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorsApp.background,
        child: Center(
          child: Stack(
            children: [
              addCustomCategories(),
              backButton(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  title(),
                  const SizedBox(
                    height: 10,
                  ),
                  selectCategories(categories, buttonColor, buttonElevations),
                  const SizedBox(height: 20),
                  inputTime(),
                  const SizedBox(height: 20),
                  buttonToStart(selectedCategory, timeInSeconds)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Text('Selecione a categoria personalizada e o tempo',
        style: GoogleFonts.girassol(
            fontSize: 30, textStyle: TextStyle(color: ColorsApp.letters)));
  }

  Widget selectCategories(List<String> categories,
      Map<String, Color> buttonColor, Map<String, double> buttonElevations) {
    if (categories.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Não há nenhuma lista personalizada",
              style: GoogleFonts.girassol(
                  fontSize: 20,
                  textStyle: TextStyle(color: ColorsApp.letters))),
        ],
      );
    }

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: categories.map((category) {
              return Stack(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Button(
                          elevation: buttonElevations[category],
                          buttonColor: buttonColor[category]!,
                          onPressed: () {
                            BackgroundMusicPlayer.loadMusic2();
                            BackgroundMusicPlayer.playBackgroundMusic(2);
                            _toggleElevation(category);
                            _selectedsCategories(category);
                          },
                          label: category)),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _navigateToCategoryDetail(category);
                        },
                        child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorsApp.color2),
                            child: const Center(
                                child: Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.white,
                            ))),
                      ))
                ],
              );
            }).toList()),
      ),
    );
  }

  Widget inputTime() {
    return SizedBox(
      width: 200,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          labelText: 'Tempo da Rodada (segundos)',
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            timeInSeconds = int.tryParse(value) ?? 60;
          });
        },
      ),
    );
  }

  Widget buttonToStart(List<String> selectedCategory, int timeInSeconds) {
    return Button(
        elevation: 10,
        buttonColor: ColorsApp.color1,
        onPressed: () async {
          if (selectedCategory.isNotEmpty) {
            BackgroundMusicPlayer.stopBackgroundMusic(1);
            BackgroundMusicPlayer.loadMusic2();
            BackgroundMusicPlayer.playBackgroundMusic(2);
            customCategories =
                await _wordsController.preloadCategories(context, false);
            Navigator.push(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(
                builder: (context) => GameScreen(
                  category: selectedCategory,
                  timeInSeconds: timeInSeconds,
                  customCategories: customCategories,
                ),
              ),
            );
          }
        },
        label: "Iniciar jogo");
  }

  Widget backButton() {
    return Positioned(
        top: 10,
        left: 10,
        child: CustomIconButton(
            elevation: 5,
            buttonColor: ColorsApp.color1,
            onPressed: () {
              BackgroundMusicPlayer.loadMusic2();
              BackgroundMusicPlayer.playBackgroundMusic(2);
              Navigator.pop(context);
            },
            icon: Icons.arrow_back,
            padding: 0));
  }

  Widget addCustomCategories() {
    return Positioned(
      bottom: 10,
      right: 10,
      child: Button(
          elevation: 5,
          buttonColor: ColorsApp.color1,
          onPressed: () {
            BackgroundMusicPlayer.loadMusic2();
            BackgroundMusicPlayer.playBackgroundMusic(2);
            addNewCategory();
          },
          label: "Adicionar listas"),
    );
  }
}
