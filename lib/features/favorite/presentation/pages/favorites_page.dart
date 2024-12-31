import 'package:flutter/material.dart';
import 'package:popular_movies/core/widgets/custom_text.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(text: "Favorite"),
      ),
    );
  }
}
