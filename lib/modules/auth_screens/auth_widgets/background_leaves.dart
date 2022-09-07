import 'package:flutter/material.dart';
import 'package:lavie_web/shared/components/image_assets.dart';
import 'dart:math' as math; // import this
class BackLeaves extends StatelessWidget {
  const BackLeaves({Key? key, required this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Image.asset(
                ImagesInAssets.treeImage,
                width: 120,
              ),
            ),
            const Spacer(),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Transform.scale(
                scaleX: -1,
                child: Image.asset(
                  ImagesInAssets.treeImage,
                  width: 120,
                ),
              ),
            ),
          ],
        ),
        child!,
      ],
    );
  }
}
