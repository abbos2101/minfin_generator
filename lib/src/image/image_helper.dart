import 'dart:io';
import 'extensions.dart';

class ImageHelper {
  final String svgAssetsPath;
  final String imageAssetsPath;
  final String widgetLibPath;

  const ImageHelper({
    required this.svgAssetsPath,
    required this.imageAssetsPath,
    required this.widgetLibPath,
  });

  Future<void> generate() async {
    print("$runtimeType Start...");
    try {
      final icons = _textImages(svgAssetsPath, widgetLibPath);
      print("$runtimeType Write icons file");
      final images = _textImages(imageAssetsPath, widgetLibPath);
      print("$runtimeType Write images file");
      final refresh = await _saveDartFile(
        widgetLibPath,
        dartContent("$icons$images"),
      );
      print("$runtimeType Success ${refresh ? "changed" : "not changed"}");
    } catch (e) {
      print("$runtimeType Fail: $e");
    }
  }

  String _textImages(String path, String widgetPath) {
    final dir = Directory("${Directory.current.path}/$path");
    final list = dir.listSync();
    list.sort((a, b) => a.path.compareTo(b.path));
    var text = "";
    for (var e in list) {
      text += "${imageText("$path/${e.path.fileName}")}\n";
    }
    return text;
  }

  Future<bool> _saveDartFile(String path, String content) async {
    final file = File("${Directory.current.path}/$path/custom_pictures.dart");
    if (await file.readAsString() != content) {
      await file.writeAsString(content);
      return true;
    }
    return false;
  }
}
