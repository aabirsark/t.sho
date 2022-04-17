import 'package:flutter/material.dart';

extension ContextDetails on BuildContext {
  /// returns screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// returns screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// returns screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// returns screen width
  double get screenAspectRatio => MediaQuery.of(this).size.aspectRatio;

  /// Responsive design 
  double responsive(double size, {Axis axis = Axis.vertical}) {
    final currentSize =
        axis == Axis.horizontal ? screenSize.width : screenSize.height;
    final designSize = axis == Axis.horizontal
        ? _AppConstants.designScreenSize.width
        : _AppConstants.designScreenSize.height;

    return size * currentSize / designSize;
  }
}

class _AppConstants {
  static const Size designScreenSize = Size(375, 754);
}
