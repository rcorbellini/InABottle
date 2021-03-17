import 'package:flutter/material.dart';

class Waves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          child: Container(
            height: 300,
            color: Colors.white,
          ),
          clipper: Wave4(),
        ),
        ClipPath(
          child: Container(
            height: 240,
            color: Color(0xff9FBAB6),
          ),
          clipper: Wave3(),
        ),
        ClipPath(
          child: Container(
            height: 180,
            color: Color(0xff67AABD),
          ),
          clipper: Wave2(),
        ),
        ClipPath(
          child: Container(
            height: 100,
            color: Color(0xff40A1C3),
          ),
          clipper: Wave1(),
        ),
      ],
    );
  }
}

class Wave1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 25)
      ..quadraticBezierTo((size.width / 6) * 1, size.height,
          (size.width / 6) * 2, size.height - 40)
      ..quadraticBezierTo((size.width / 6) * 3, size.height - 80,
          (size.width / 6) * 4, size.height - 40)
      ..quadraticBezierTo((size.width / 6) * 5, size.height,
          (size.width / 6) * 6, size.height - 20)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class Wave2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 5)
      ..quadraticBezierTo((size.width / 10) * 1, size.height,
          (size.width / 10) * 2, size.height - 60)
      ..quadraticBezierTo((size.width / 6) * 2, size.height - 120,
          (size.width / 10) * 5, size.height - 40)
      ..quadraticBezierTo((size.width / 6) * 4, size.height + 40,
          (size.width / 10) * 10, size.height - 40)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class Wave3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 15)
      ..quadraticBezierTo((size.width / 10) * 3, size.height,
          (size.width / 10) * 3.5, size.height - 40)
      ..quadraticBezierTo((size.width / 10) * 4.5, size.height - 75,
          (size.width / 10) * 5.5, size.height - 20)
      ..quadraticBezierTo((size.width / 10) * 6, size.height + 10,
          (size.width / 10) * 7, size.height - 10)
      ..quadraticBezierTo((size.width / 10) * 8, size.height - 50,
          (size.width / 10) * 10, size.height)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class Wave4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 15)
      ..quadraticBezierTo((size.width / 6) * 1, size.height,
          (size.width / 6) * 2, size.height - 40)
      ..quadraticBezierTo((size.width / 6) * 3, size.height - 80,
          (size.width / 6) * 4, size.height - 40)
      ..quadraticBezierTo((size.width / 6) * 5, size.height,
          (size.width / 6) * 6, size.height - 15)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}