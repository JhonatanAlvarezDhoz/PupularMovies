import 'package:flutter/material.dart';

class AnimatedLoadingBar extends StatefulWidget {
  final double width;
  final double height;
  final Duration duration;
  final Color backgroundColor;
  final Color progressColor;
  final VoidCallback? onComplete;

  const AnimatedLoadingBar({
    super.key,
    this.width = 200.0,
    this.height = 10.0,
    required this.duration,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
    this.onComplete,
  });

  @override
  AnimatedLoadingBarState createState() => AnimatedLoadingBarState();
}

class AnimatedLoadingBarState extends State<AnimatedLoadingBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete?.call();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.height / 2),
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _animation.value,
            child: Container(
              decoration: BoxDecoration(
                color: widget.progressColor,
                borderRadius: BorderRadius.circular(widget.height / 2),
              ),
            ),
          );
        },
      ),
    );
  }
}
