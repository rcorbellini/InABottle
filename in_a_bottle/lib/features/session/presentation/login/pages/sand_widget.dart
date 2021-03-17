import 'package:flutter/material.dart';

class Sand extends StatelessWidget {
  const Sand();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          child: Container(
            height: 480,
            color: Color(0xffECCA95),
          ),
          clipper: Sand3(),
        ),
        ClipPath(
          child: Container(
            height: 360,
            color: Color(0xffE7C28F),
          ),
          clipper: Sand2(),
        ),
        ClipPath(
          child: Container(
            height: 310,
            color: Color(0xffDAB182),
          ),
          clipper: Sand1(),
        )
      ],
    );
  }
}

class Sand1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 5)
      ..quadraticBezierTo((size.width / 6) * 1, size.height,
          (size.width / 6) * 1.9, size.height - 45)
      ..quadraticBezierTo((size.width / 6) * 3, size.height - 85,
          (size.width / 6) * 4.2, size.height - 40)
      ..quadraticBezierTo((size.width / 6) * 5, size.height,
          (size.width / 6) * 6, size.height - 10)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class Sand2 extends CustomClipper<Path> {
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

class Sand3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo((size.width / 10) * 1, size.height,
          (size.width / 10) * 2, size.height - 60)
      ..quadraticBezierTo((size.width / 10) * 2.5, size.height - 120,
          (size.width / 10) * 4, size.height - 60)
      ..quadraticBezierTo((size.width / 10) * 5, size.height - 40,
          (size.width / 10) * 6, size.height - 100)
      ..quadraticBezierTo((size.width / 10) * 7.5, size.height - 140,
          (size.width / 10) * 8, size.height - 80)
      ..quadraticBezierTo((size.width / 10) * 8.5, size.height - 30,
          (size.width / 10) * 10, size.height - 20)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
