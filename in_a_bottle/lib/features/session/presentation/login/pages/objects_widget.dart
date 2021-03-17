import 'package:flutter/material.dart';

class Floater extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = 220.0;
    final righPosition = 42.0;
    final bottomPosition = 80.0;
    final smallCenterBallSize = size / 10;
    return Stack(
      children: [
        Positioned(
            right: righPosition - 60,
            bottom: bottomPosition + 60,
            child: ClipOval(
              child: Container(
                height: size,
                width: size,
                color: Color(0xffECCA95),
              ),
            )),
        Positioned(
          right: righPosition,
          bottom: bottomPosition,
          child: ClipOval(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(32 / 360),
              child: CustomPaint(
                size: Size(size, size),
                painter: PathPainter(color: Color(0xff33A1C3)),
              ),
            ),
          ),
        ),
        Positioned(
          right: righPosition,
          bottom: bottomPosition,
          child: ClipOval(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(64 / 360),
              child: CustomPaint(
                size: Size(size, size),
                painter: PathPainter(color: Color(0xffF46C55)),
              ),
            ),
          ),
        ),
        Positioned(
          right: righPosition,
          bottom: bottomPosition,
          child: ClipOval(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(128 / 360),
              child: CustomPaint(
                size: Size(size, size),
                painter: PathPainter(color: Color(0xff33A1C3)),
              ),
            ),
          ),
        ),
        Positioned(
          right: righPosition,
          bottom: bottomPosition,
          child: ClipOval(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(154 / 360),
              child: CustomPaint(
                size: Size(size, size),
                painter: PathPainter(color: Color(0xffF46C55)),
              ),
            ),
          ),
        ),
        Positioned(
          right: righPosition,
          bottom: bottomPosition,
          child: ClipOval(
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(96 / 360),
              child: CustomPaint(
                size: Size(size, size),
                painter: PathPainter(color: Color(0xffF9F5E2)),
              ),
            ),
          ),
        ),
        Positioned(
          right: righPosition,
          bottom: bottomPosition,
          child: ClipOval(
            child: CustomPaint(
              size: Size(size, size),
              painter: PathPainter(color: Color(0xffF9F5E2)),
            ),
          ),
        ),
        Positioned(
          right: righPosition + size / 2 - smallCenterBallSize / 2,
          bottom: bottomPosition + size / 2 - smallCenterBallSize / 2,
          child: ClipPath(
            child: ClipOval(
              child: Container(
                height: smallCenterBallSize,
                width: smallCenterBallSize,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Umbrella extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = 90.0;
    final leftPosition = 45.0;
    final topPosition = 70.0;

    return Stack(
      children: [
        Positioned(
          left: leftPosition + 15,
          top: topPosition - 15,
          child: ClipOval(
            child: ClipPath(
              child: Container(
                height: size,
                width: size,
                color: Color(0xff3395BD),
              ),
              clipper: InvertedClipper(),
            ),
          ),
        ),
        Positioned(
          left: leftPosition,
          top: topPosition,
          child: ClipOval(
            child: ClipPath(
              child: Container(
                height: size,
                width: size,
                color: Colors.white,
              ),
              clipper: InvertedClipper(),
            ),
          ),
        ),
        Positioned(
          left: leftPosition - 1,
          top: topPosition - 1,
          child: ClipPath(
            child: ClipOval(
              child: ClipPath(
                child: Container(
                  height: size + 2,
                  width: size + 2,
                  color: Color(0xffF46C55),
                ),
                clipper: InvertedClipper(),
              ),
            ),
            clipper: BoiaClip(),
          ),
        )
      ],
    );
  }
}

class InvertedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: 30))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BoiaClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addRect(Rect.fromLTRB(
          size.width / 2 - 15, 0, size.width / 2 + 15, size.height))
      ..addRect(Rect.fromLTRB(
          0, size.width / 2 - 15, size.height, size.width / 2 + 15));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class PathPainter extends CustomPainter {
  final Color color;

  PathPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = this.color
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    Path path = Path()
      ..moveTo(0, 40)
      ..lineTo(size.width, size.height - 40)
      ..lineTo(size.width, (size.height / 2))
      ..lineTo(0, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
