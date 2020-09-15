import 'dart:math' as math show sin, pi;
import 'package:flutter/material.dart';

///Classe responsável por mostrar um loading
class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({
    this.color = Colors.red,
    this.size = 50.0,
    this.duration = const Duration(milliseconds: 1200),
  }) : super();

  final Color color;
  final double size;
  final Duration duration;
  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with TickerProviderStateMixin {
  final List<double> delays = [
    .0,
    -1.1,
    -1.0,
    -0.9,
    -0.8,
    -0.7,
    -0.6,
    -0.5,
    -0.4,
    -0.3,
    -0.2,
    -0.1
  ];
  AnimationController _controller;

  Color get color => widget.color;
  double get size => widget.size;
  Duration get duration => widget.duration;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox.fromSize(
            size: Size.square(size),
            child: Stack(
              children: List.generate(delays.length, (index) {
                final _position = size * .5;
                return Positioned.fill(
                  left: _position,
                  top: _position,
                  child: Transform(
                    transform: Matrix4.rotationZ(30.0 * index * 0.0174533),
                    child: Align(
                      alignment: Alignment.center,
                      child: ScaleTransition(
                        scale: DelayTween(
                                begin: 0.0, end: 1.0, delay: delays[index])
                            .animate(_controller),
                        child: SizedBox.fromSize(
                            size: Size.square(size * 0.15),
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: color, shape: BoxShape.circle))),
                      ),
                    ),
                  ),
                );
              }),
            )));
  }
}

class DelayTween extends Tween<double> {
  DelayTween({double begin, double end, this.delay})
      : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) =>
      super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
