import 'package:flutter/material.dart';

class LBCard extends StatelessWidget {
  final Color? color;

  final EdgeInsets? margin;

  final Widget? child;

  final ShapeBorder? shape;

  final double? elevation;

  const LBCard({
    Key? key,
    this.color,
    this.margin,
    this.child,
    this.shape,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 2,
      shape: shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: child,
      color: color,
      margin: margin,
    );
  }
}
