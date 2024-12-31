import 'package:flutter/material.dart';

enum AnimationType {
  fadeIn,
  fadeOut,
  zoomIn,
  zoomOut,
  slideInFromLeft,
}

class AnimatedEntryWidget extends StatefulWidget {
  final Widget child;
  final AnimationType type;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onComplete;

  const AnimatedEntryWidget({
    super.key,
    required this.child,
    required this.type,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.onComplete,
  });

  @override
  AnimatedEntryWidgetState createState() => AnimatedEntryWidgetState();
}

class AnimatedEntryWidgetState extends State<AnimatedEntryWidget>
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

    switch (widget.type) {
      case AnimationType.fadeIn:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
      case AnimationType.fadeOut:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
      case AnimationType.zoomIn:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
      case AnimationType.zoomOut:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
      case AnimationType.slideInFromLeft:
        _animation = Tween<double>(begin: -1.0, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
    }

    _animation.addStatusListener((status) {
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        switch (widget.type) {
          case AnimationType.fadeIn:
          case AnimationType.fadeOut:
            return Opacity(
              opacity: _animation.value,
              child: widget.child,
            );
          case AnimationType.zoomIn:
          case AnimationType.zoomOut:
            return Transform.scale(
              scale: _animation.value,
              child: widget.child,
            );
          case AnimationType.slideInFromLeft:
            return Transform.translate(
              offset: Offset(
                  _animation.value * MediaQuery.of(context).size.width, 0),
              child: widget.child,
            );
        }
      },
    );
  }
}
