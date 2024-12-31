import 'package:flutter/material.dart';
import 'package:popular_movies/core/constants/app_sizes.dart';
import 'package:popular_movies/core/utils/responsive.dart';
import 'package:popular_movies/core/widgets/custom_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: responsive.heightResponsive(30),
          width: responsive.widthResponsive(100),
          child: Image.asset(
            "assets/images/profile.jpeg",
            fit: BoxFit.cover,
          ),
        ),
        gapH12,
        CustomText(
          text: "Jhon Dou",
          fontSize: 30,
          fontWeight: FontWeight.w500,
        )
      ],
    ));
  }
}
