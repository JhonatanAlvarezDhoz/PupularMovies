// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popular_movies/core/config/theme/app_colors.dart';
import 'package:popular_movies/core/utils/responsive.dart';
import 'package:popular_movies/core/widgets/icon_navbar.dart';
import 'package:popular_movies/core/widgets/widgets.dart';

const homeTab = 0;
const locationTab = 1;
const profileTab = 2;

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.onChange,
    required this.currentIndex,
  });

  final ValueChanged<int> onChange;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return SafeArea(
      top: false,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: responsive.widthResponsive(3)),
        height: responsive.heightResponsive(7),
        width: responsive.widthResponsive(85),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            iconNavBottomBar.length,
            (index) {
              IconNavBottomBar item = iconNavBottomBar[index];

              return _BottomAnimatedContainer(
                index: index,
                isActive: currentIndex == index,
                item: item,
                onChanged: (int value) {
                  onChange(value);
                },
                isOff: currentIndex != index,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BottomAnimatedContainer extends StatefulWidget {
  const _BottomAnimatedContainer({
    required this.item,
    required this.isActive,
    required this.index,
    required this.onChanged,
    required this.isOff,
  });

  final IconNavBottomBar item;
  final bool isActive;
  final bool isOff;
  final int index;
  final ValueChanged<int> onChanged;

  @override
  State<_BottomAnimatedContainer> createState() =>
      _BottomAnimatedContainerState();
}

class _BottomAnimatedContainerState extends State<_BottomAnimatedContainer> {
  Color choiceColor(BuildContext context) {
    if (widget.isActive) {
      return AppColors.white;
    } else {
      return AppColors.primary;
    }
  }

  Color choiceColorOff(BuildContext context) {
    if (widget.isActive) {
      return AppColors.primary;
    } else {
      return AppColors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    Color backgroundColor = choiceColor(context);

    return TweenAnimationBuilder(
      curve: Curves.ease,
      tween: Tween(begin: 0.0, end: widget.isActive ? 1.0 : 0.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        final double width = value * responsive.diagonalResponsive(11) +
            responsive.heightResponsive(5.5);
        return GestureDetector(
          onTap: () {
            if (!widget.isActive) {
              widget.onChanged(widget.index);
            }
          },
          child: Container(
            height: responsive.heightResponsive(4.5),
            width: widget.isActive ? width : responsive.widthResponsive(14),
            margin: const EdgeInsets.symmetric(horizontal: 1),
            alignment: Alignment.center,
            padding: widget.isActive
                ? const EdgeInsets.symmetric(horizontal: 13)
                : const EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: backgroundColor,
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedPositioned(
                    left: 0,
                    width: constraints.maxWidth * .4,
                    duration: const Duration(milliseconds: 0),
                    child: SvgPicture.asset(
                      widget.item.iconString,
                      width: widget.isActive
                          ? constraints.maxWidth * .26
                          : constraints.maxWidth * .4,
                      color: widget.isActive
                          ? AppColors.primary
                          : choiceColorOff(context),
                    ),
                  ),
                  if (widget.isActive)
                    Positioned(
                      right: constraints.maxWidth * .08,
                      width: constraints.maxWidth * .6,
                      child: AnimatedOpacity(
                        opacity: value > 0.7 ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: FittedBox(
                          fit: BoxFit.none,
                          child: CustomText(
                            text: widget.item.title!,
                            fontSize: responsive.diagonalResponsive(1.8),
                            color: widget.isActive
                                ? AppColors.primary
                                : choiceColorOff(context),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
