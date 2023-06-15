import 'package:flutter/material.dart';

class MyLoadingWidget extends StatefulWidget {
  const MyLoadingWidget({super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  State<MyLoadingWidget> createState() => _MyLoadingWidgetState();
}

class _MyLoadingWidgetState extends State<MyLoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _fadeController;
  late CurvedAnimation _rotationAnimation;
  late CurvedAnimation _fadeAnimation;
  @override
  void initState() {
    _rotationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    )..repeat();
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );
    _rotationAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _rotationController,
    );
    _fadeAnimation = CurvedAnimation(
      curve: Curves.linear,
      parent: _fadeController,
    );
    _fadeController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _fadeController.dispose();
    _rotationAnimation.dispose();
    _fadeAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: RotationTransition(
          turns: _rotationAnimation,
          child: Image.asset("assets/images/Crypto.png"),
        ),
      ),
    );
  }
}
