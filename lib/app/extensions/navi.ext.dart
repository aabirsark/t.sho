import 'package:flutter/material.dart';

extension RxNavigation on BuildContext {
  ///  Navigate to a particular route
  void navigateTo(Widget child) => Navigator.push(this, _animateRoute(child));

  /// Navigate back
  void navigateBack() => Navigator.pop(this);

  /// Replace sreen with named route
  void replaceScreen({required Widget child}) =>
      Navigator.pushReplacement(this, _animateRoute(child));
}

Route _animateRoute(Widget _child) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => _child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      });
}
