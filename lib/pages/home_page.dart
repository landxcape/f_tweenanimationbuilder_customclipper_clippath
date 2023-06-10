import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _randomColor = getRandomColor();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: const CircleClipper(),
          child: TweenAnimationBuilder(
            duration: const Duration(seconds: 1),
            tween: ColorTween(
              begin: getRandomColor(),
              end: _randomColor,
            ),
            child: Container(
              height: size.width,
              width: size.width,
              color: getRandomColor(),
            ),
            onEnd: () => setState(() {
              _randomColor = getRandomColor();
            }),
            builder: (context, color, child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(color!, BlendMode.srcATop),
                child: child!,
              );
            },
          ),
        ),
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  const CircleClipper();

  @override
  Path getClip(Size size) {
    final path = Path();

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    path.addOval(rect);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Color getRandomColor() => Color(0xFF000000 + Random().nextInt(0x00FFFFFF));
