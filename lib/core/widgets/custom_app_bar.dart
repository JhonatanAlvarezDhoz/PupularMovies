import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? elevation;
  final Color? backgroundColor;
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    this.elevation = 0,
    this.backgroundColor = Colors.white,
    this.leading,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final appBarContent = AppBar(
      elevation: elevation,
      backgroundColor: backgroundColor,
      leading: leading ??
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                "assets/logos/logo.png",
                width: 100,
              )),
      title: Align(
          alignment: Alignment.center,
          child: title ??
              Image.asset(
                "assets/icons/icon.png",
                width: 120,
              )),
      actions: actions ?? [],
    );

    // Si no se proporciona ningún blocBuilder, devuelve solo la AppBar genérica
    return appBarContent;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
