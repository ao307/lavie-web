import 'package:flutter/material.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';

import '../../../shared/components/image_assets.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({Key? key, required this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Image.asset(
                ImagesInAssets.homeBackgroundImage,
                width: screenW(context) * .4,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: RotatedBox(
                quarterTurns: 90,
                child: Image.asset(
                  ImagesInAssets.homeBackgroundImage,
                  width: screenW(context) * .4,
                  fit: BoxFit.cover,
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
