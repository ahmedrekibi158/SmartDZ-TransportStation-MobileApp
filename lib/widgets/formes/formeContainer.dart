import 'dart:math';

import 'package:flutter/material.dart';

import 'customClipper.dart';

class FormeContainer extends StatelessWidget {
  const FormeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
      angle: -pi / 3.5,
      child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height * .3,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(),
        ),
      ),
    ));
  }
}
