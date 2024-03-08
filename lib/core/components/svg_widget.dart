import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:r_p_s_game/core/base/modules/extension/asset_extension.dart';

Widget svgWidget(GameAsset asset, double height) {
  return SvgPicture.asset(
    asset.assetPath,
    height: height,
  );
}

Widget iconWidget(IconData icon, double size) {
  return Icon(icon, size: size);
}
