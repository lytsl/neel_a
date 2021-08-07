import 'dart:async';

import 'package:flutter/material.dart';

@immutable
class CustomModalSheet extends StatefulWidget {
  final CustomModalSheetDirection direction;
  final Color backgroundColor;
  final Widget child;

  CustomModalSheet({required this.child,this.direction =CustomModalSheetDirection.BOTTOM, this.backgroundColor = const Color(0xb3212121)});

  @override
  _CustomModalSheetState createState() => _CustomModalSheetState();

  static show(
      {required BuildContext context,
        required child,
        direction = CustomModalSheetDirection.BOTTOM,
        backgroundColor = const Color(0xb3212121)}) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) {
              return CustomModalSheet(
                child: child,
                direction: direction,
                backgroundColor: backgroundColor,
              );
            },
            opaque: false));
  }
}

class _CustomModalSheetState extends State<CustomModalSheet>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  late AnimationController _controller;
  late BorderRadiusTween borderRadius;

  final GlobalKey _childKey = GlobalKey();
  Duration _duration = Duration(milliseconds: 400);

  double get _childHeight {
    final RenderBox renderBox = (_childKey.currentContext!.findRenderObject()) as RenderBox;
    return renderBox.size.height;
  }

  bool get _dismissUnderway =>
      _animationController.status == AnimationStatus.reverse;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: _duration);

    _animation = Tween<double>(begin: _isDirectionTop() ? -1 : 1, end: 0)
        .animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) Navigator.pop(context);
    });

    _controller = AnimationController(vsync: this, duration: _duration);

    borderRadius = BorderRadiusTween(
      begin: BorderRadius.only(
        topRight: Radius.circular(16.0),
        topLeft: Radius.circular(16.0),
      ),
      end: BorderRadius.only(
        topRight: Radius.circular(0.0),
        topLeft: Radius.circular(0.0),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_dismissUnderway) return;

    var change = details.primaryDelta! / (_childHeight);
    if (_isDirectionTop())
      _animationController.value += change;
    else
      _animationController.value -= change;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dismissUnderway) return;

    if (details.velocity.pixelsPerSecond.dy > 0 && _isDirectionTop()) return;
    if (details.velocity.pixelsPerSecond.dy < 0 && !_isDirectionTop()) return;

    if (details.velocity.pixelsPerSecond.dy > 700) {
      final double flingVelocity =
          -details.velocity.pixelsPerSecond.dy / _childHeight;
      if (_animationController.value > 0.0)
        _animationController.fling(velocity: flingVelocity);
    } else if (_animationController.value < 0.5) {
      if (_animationController.value > 0.0)
        _animationController.fling(velocity: -1.0);
    } else
      _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: onBackPressed,
        child: GestureDetector(
          onVerticalDragUpdate: _handleDragUpdate,
          onVerticalDragEnd: _handleDragEnd,
          child: Scaffold(
            backgroundColor: widget.backgroundColor,
            body: SafeArea(
              child: Column(
                key: _childKey,
                children: <Widget>[
                  _isDirectionTop() ? Container() : Spacer(),
                  AnimatedBuilder(
                      animation: _animation,
                      builder: (context, _) {
                        return Transform(
                          transform: Matrix4.translationValues(
                              0.0, width * _animation.value, 0.0),
                          child: Container(
                            width: width,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              /*borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16.0),
                                topLeft: Radius.circular(16.0),
                              ),*/
                              borderRadius: borderRadius.evaluate(CurvedAnimation(parent: _controller, curve: Curves.ease)),
                            ),
                            child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {},
                                child: widget.child,
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
          excludeFromSemantics: true,
        ));
  }

  bool _isDirectionTop() {
    return widget.direction == CustomModalSheetDirection.TOP;
  }

  Future<bool> onBackPressed() {
    _animationController.reverse();
    return Future<bool>.value(false);
  }
}

enum CustomModalSheetDirection { TOP, BOTTOM }