import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:popular_movies/core/config/theme/app_colors.dart';
import 'package:popular_movies/core/constants/app_sizes.dart';
import 'package:popular_movies/core/widgets/custom_text.dart';

class CustomButton extends ElevatedButton {
  CustomButton({
    required this.text,
    super.onPressed,
    this.color = AppColors.primary,
    super.key,
    this.borderRadius,
    this.borderColor,
    this.splashColor,
    this.padding,
    this.elevation,
    this.textWeight,
    this.textSize,
    this.textColor,
    this.buttonSize,
    this.withIcon = false,
    this.assetName = "",
  }) : super(
            style: ButtonStyle(
              fixedSize: WidgetStateProperty.all(buttonSize),
              elevation: WidgetStateProperty.all(elevation ?? 0),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(8),
                  side: BorderSide(
                      color: borderColor ?? color ?? AppColors.white),
                ),
              ),
              overlayColor: WidgetStateProperty.all<Color>(
                  splashColor ?? AppColors.white.withOpacity(0.1)),
              backgroundColor:
                  WidgetStateProperty.all<Color>(color ?? AppColors.white),
              foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return AppColors.white;
                  }
                  return AppColors.primary;
                },
              ),
            ),
            child: SizedBox(
              child: withIcon
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          assetName,
                          width: 30,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        gapW4,
                        CustomText(
                          text: text,
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    )
                  : Center(
                      child: FittedBox(
                        child: CustomText(
                          text: text,
                          color: textColor ?? AppColors.white,
                          fontWeight: textWeight ?? FontWeight.w900,
                          fontSize: textSize ?? 14,
                        ),
                      ),
                    ),
            ));

  final String text;
  final Color? color;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? splashColor;
  final EdgeInsets? padding;
  final double? elevation;
  final FontWeight? textWeight;
  final double? textSize;
  final Color? textColor;
  final Size? buttonSize;
  final bool withIcon;
  final String assetName;
}
