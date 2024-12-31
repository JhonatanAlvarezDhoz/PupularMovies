import 'package:flutter/material.dart';
import 'package:popular_movies/core/config/theme/app_colors.dart';
import 'package:popular_movies/core/widgets/custom_text.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar(
      {super.key,
      required String message,
      String labelButtom = "ok",
      required Color color,
      super.duration = const Duration(seconds: 2),
      VoidCallback? onOk})
      : super(
            content: CustomText(
              text: message,
              color: AppColors.white,
            ),
            backgroundColor: color,
            action: SnackBarAction(
                label: labelButtom,
                onPressed: () {
                  if (onOk != null) {
                    onOk();
                  }
                }));
}
