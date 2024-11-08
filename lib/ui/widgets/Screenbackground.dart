import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_path.dart';

class background extends StatelessWidget {
  const background({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        SvgPicture.asset(
          Assetspath.backgroundsvg,
          fit: BoxFit.cover,
          width: screensize.width,
          height: screensize.height,
        ),
        SafeArea(child: child),
        // safe area amr phone er knox time camera etc bade je pure screen area ase oikhane content rakhe
      ],
    );
  }
}
