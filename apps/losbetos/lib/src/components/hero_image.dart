import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  final ImageProvider<Object> image;
  final Widget? child;

  const HeroImage({
    Key? key,
    required this.image,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey(image),
      child: BoxImage(image: image, child: child),
    );
  }
}

class BoxImage extends StatelessWidget {
  const BoxImage({
    Key? key,
    required this.image,
    required this.child,
  }) : super(key: key);

  final ImageProvider<Object> image;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
