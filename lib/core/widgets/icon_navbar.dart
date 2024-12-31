import 'package:flutter/material.dart';

class IconNavBottomBar {
  String iconString;
  String? title;
  Color? color;

  IconNavBottomBar({required this.iconString, this.title, this.color});
}

List<IconNavBottomBar> iconNavBottomBar = [
  IconNavBottomBar(
    iconString: "assets/icons/home.svg",
    title: "Home",
  ),
  IconNavBottomBar(
    iconString: "assets/icons/favorite.svg",
    title: "Favorite",
  ),
  IconNavBottomBar(
    iconString: "assets/icons/profile.svg",
    title: "Profile",
  )
];
