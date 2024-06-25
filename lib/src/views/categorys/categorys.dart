import 'package:flutter/material.dart';

class Categorys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CategoryButton(category: 'Animais'),
            CategoryButton(category: 'Filmes'),
            CategoryButton(category: 'Objetos'),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String category;

  CategoryButton({required this.category});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(category),
    );
  }
}
