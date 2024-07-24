import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/music.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/icon_button.dart';
import '../gameScreen/game_screen.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<String> selectedCategory = [];
  int timeInSeconds = 60;
  Map<String, double> buttonElevations = {};
  Map<String, Color> buttonColor = {};
  List<String> categorys = [
    "Geral",
    "Verbos",
    "Filmes",
    "Objetos",
    "Animais",
    "Profissões"
  ];

  @override
  void initState() {
    super.initState();
    for (var category in categorys) {
      buttonColor[category] = ColorsApp.color1;
      buttonElevations[category] = 10.0;
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
              customCategories(),
              backButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Text('Selecione a categoria e o tempo',
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
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Button(
                    elevation: buttonElevations[category],
                    buttonColor: buttonColor[category]!,
                    onPressed: () {
                      BackgroundMusicPlayer.loadMusic2();
                      BackgroundMusicPlayer.playBackgroundMusic(2);
                      _toggleElevation(category);
                      _selectedsCategorys(category);
                    },
                    label: category));
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

  Widget customCategories() {
    return Positioned(
      top: 10,
      right: 10,
      child: Button(
          elevation: 5,
          buttonColor: ColorsApp.color1,
          onPressed: () {
            BackgroundMusicPlayer.loadMusic2();
            BackgroundMusicPlayer.playBackgroundMusic(2);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Category()),
            );
          },
          label: "Personalizado"),
    );
  }
}
