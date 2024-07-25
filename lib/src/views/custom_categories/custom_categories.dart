import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  // ignore: library_private_types_in_public_api
  _CustomCategoriesState createState() => _CustomCategoriesState();
}

class _CustomCategoriesState extends State<CustomCategories> {
  List<String> selectedCategory = [];
  int timeInSeconds = 60;
  Map<String, double> buttonElevations = {};
  Map<String, Color> buttonColor = {};
  List<String> categorys = [];
  final WordsController _wordsController = WordsController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
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
        return AlertDialog(
          title: const Text('Adicionar Nova Lista'),
          content: TextField(
            controller: textFieldController,
            decoration:
                const InputDecoration(hintText: "Digite o nome da nova lista"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Adicionar'),
              onPressed: () {
                newCategory = textFieldController.text.trim();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    if (newCategory.isNotEmpty && !categorys.contains(newCategory)) {
      await _wordsController.addCategory(userEmail, userId, newCategory);
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
              addCustomCategories(),
              backButton()
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
                      onTap: () {},
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
        onPressed: () {
          if (selectedCategory != []) {
            BackgroundMusicPlayer.stopBackgroundMusic(1);
            BackgroundMusicPlayer.loadMusic2();
            BackgroundMusicPlayer.playBackgroundMusic(2);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameScreen(
                  category: selectedCategory,
                  timeInSeconds: timeInSeconds,
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
