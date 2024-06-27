import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import '../gameScreen/game_screen.dart';

class Category extends StatefulWidget {
  @override
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
        buttonColor[category] = ColorsApp.color2;
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
                  Text('Selecione a categoria e o tempo',
                      style: GoogleFonts.girassol(
                          fontSize: 30,
                          textStyle: TextStyle(color: ColorsApp.letters))),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: categorys.map((category) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  buttonColor[category]),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                              shadowColor:
                                  MaterialStateProperty.all(ColorsApp.color4),
                              elevation: MaterialStateProperty.all(
                                  buttonElevations[category]),
                            ),
                            onPressed: () {
                              _toggleElevation(category);
                              _selectedsCategorys(category);
                            },
                            child: Text(category,
                                style: GoogleFonts.girassol(
                                    fontSize: 20,
                                    textStyle:
                                        TextStyle(color: ColorsApp.letters))),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 200,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Tempo da Rodada (segundos)',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        timeInSeconds = int.tryParse(value) ?? 60;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorsApp.color1),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      shadowColor: MaterialStateProperty.all(ColorsApp.color4),
                      elevation: MaterialStateProperty.all(10),
                    ),
                    onPressed: () {
                      if (selectedCategory != []) {
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Iniciar jogo',
                          style: GoogleFonts.girassol(
                              fontSize: 20,
                              textStyle: TextStyle(color: ColorsApp.letters))),
                    ),
                  ),
                ],
              ),
              Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
