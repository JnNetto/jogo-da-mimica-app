import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimica_att/src/database/lists_database.dart';
import 'package:mimica_att/src/views/custom_categories_details/custom_categories_details.dart';
import '../../../authentication.dart';
import '../../controllers/words_controller.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/music.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/icon_button.dart';
import '../gameScreen/game_screen.dart';

class CustomCategories extends StatefulWidget {
  const CustomCategories({super.key});

  @override
  _CustomCategoriesState createState() => _CustomCategoriesState();
}

class _CustomCategoriesState extends State<CustomCategories> {
  List<String> selectedCategory = [];
  int timeInSeconds = 60;
  Map<String, double> buttonElevations = {};
  Map<String, Color> buttonColor = {};
  List<String> categorys = [];
  final WordsController _wordsController = WordsController();
  final ListsDatabase listsDatabase = ListsDatabase();

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
    _loadCategories();
  }

  Future<void> _initializeDatabase() async {
    await listsDatabase.initHive();
  }

  Future<void> _loadCategories() async {
    String userEmail = Authentication.user?.email ?? "defaultEmail";
    String userId = Authentication.user?.uid ?? "defaultId";

    List<String> categories =
        await _wordsController.getTitleCategories(userEmail, userId);
    setState(() {
      categorys = categories;
      for (var category in categorys) {
        buttonColor[category] = ColorsApp.color1;
        buttonElevations[category] = 10.0;
      }
    });
  }

  Future<void> addNewCategory() async {
    String userEmail = Authentication.user?.email ?? "defaultEmail";
    String userId = Authentication.user?.uid ?? "defaultId";

    TextEditingController textFieldController = TextEditingController();
    String newCategory = "";

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {
            return AlertDialog(
              title: !isKeyboardVisible
                  ? Text(
                      'Adicionar Nova Lista',
                      style: TextStyle(color: ColorsApp.letters),
                    )
                  : null,
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
              actions: !isKeyboardVisible
                  ? <Widget>[
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
                              !categorys.contains(newCategory)) {
                            await _wordsController.addCategory(
                                userEmail, userId, newCategory);
                            setState(() {
                              categorys.add(newCategory);
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
                    ]
                  : [],
            );
          },
        );
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

  void _selectedsCategorys(String category) {
    setState(() {
      if (buttonElevations[category] == 0) {
        selectedCategory.add(category);
      } else {
        selectedCategory.remove(category);
      }
    });
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
                  selectCategorys(categorys, buttonColor, buttonElevations),
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

  Widget selectCategorys(List<String> categorys, Map<String, Color> buttonColor,
      Map<String, double> buttonElevations) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: categorys.map((category) {
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
                          _selectedsCategorys(category);
                        },
                        label: category)),
                Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CategoryDetailScreen(categoryName: category)),
                        );
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
          }).toList(),
        ),
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
            Map<String, List<String>> customCategories =
                await _wordsController.preloadCategories();
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
