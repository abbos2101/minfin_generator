import '../extensions.dart';

extension StringImage on String {
  String get fileName {
    final index = lastIndexOf("/");
    if (index != -1) {
      return substring(index + 1);
    }
    return this;
  }

  String get name {
    final index = lastIndexOf("/");
    if (index != -1) {
      return substring(index + 1, indexOf("."));
    }
    return this;
  }
}

String imageText(String path) {
  var widgetType = "Image";
  var name = "im_${path.name}";
  if (path.contains(".svg")) {
    widgetType = "SvgPicture";
    name = "ic_${path.name}";
  }
  return """
    static $widgetType ${name.toCamelCase()} = $widgetType.asset("$path");
  """;
}

String dartContent(String content) {
  return """
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPictures {
  const CustomPictures._();

$content
}

extension CustomSvg on SvgPicture {
  SvgPicture copyWith({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    final picture = pictureProvider as ExactAssetPicture;
    if (colorFilter != null) {
      var colorString = "\$colorFilter"
          .substring("\$colorFilter".indexOf("value: Color(") + 13);
      colorString = colorString.substring(0, colorString.indexOf(")),"));
      color = color ?? Color(int.parse(colorString));
    }
    return SvgPicture.asset(
      picture.assetName,
      width: width ?? this.width,
      height: height ?? this.height,
      fit: fit ?? this.fit,
      color: color,
    );
  }

  String get path => (pictureProvider as ExactAssetPicture).assetName;
}

extension Extension on Image {
  Image copyWith({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    return Image(
      src.image: src.image,
      width: width ?? this.width,
      height: height ?? this.height,
      fit: fit ?? this.fit,
      color: color ?? this.color,
    );
  }

  String get path {
    final path = "\$src.image";
    const key = ', name: "';
    if (path.contains(key)) {
      return path.substring(path.indexOf(key) + key.length, path.length - 2);
    }
    return "";
  }
}  
  """;
}
