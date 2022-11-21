library minfin_generator;

import 'package:flutter/foundation.dart';
import 'src/image/image_helper.dart';

/*
   [Example]
   await generateImage(
    svgAssetsPath: "assets/icons",
    imageAssetsPath: "assets/images",
    widgetLibPath: "lib/widgets",
  );
  **/
Future<void> generateImage({
  required String svgAssetsPath,
  required String imageAssetsPath,
  required String widgetLibPath,
  bool enabled = true,
}) async {
  if (enabled && kDebugMode) {
    await ImageHelper(
      svgAssetsPath: svgAssetsPath,
      imageAssetsPath: imageAssetsPath,
      widgetLibPath: widgetLibPath,
    ).generate();
  }
}
