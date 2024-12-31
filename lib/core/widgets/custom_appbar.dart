import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:popular_movies/core/widgets/widgets.dart';

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
              icon: const Icon(Icons.arrow_back_ios)),
      title: Align(
        alignment: Alignment.center,
        child: title ?? CustomText(text: "title"),
      ),
      actions: actions ??
          [
            ProfileButton(
              onTap: () {
                log("navigate to profile");
                // Navigator.pushNamed(context, AppRoutes.profile);
              },
            ),
          ],
    );

    // Si no se proporciona ningún blocBuilder, devuelve solo la AppBar genérica
    return appBarContent;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
