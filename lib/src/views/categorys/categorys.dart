import 'package:flutter/material.dart';

import '../gameScreen/game_screen.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String? selectedCategory;
  int timeInSeconds = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecionar Categoria e Tempo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              hint: Text('Selecione uma Categoria'),
              value: selectedCategory,
              items: ['Verbos', 'Filmes', 'Objetos'].map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Tempo da Rodada (segundos)',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                timeInSeconds = int.tryParse(value) ?? 60;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedCategory != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(
                        category: selectedCategory!,
                        timeInSeconds: timeInSeconds,
                      ),
                    ),
                  );
                }
              },
              child: Text('Iniciar Jogo'),
            ),
          ],
        ),
      ),
    );
  }
}
