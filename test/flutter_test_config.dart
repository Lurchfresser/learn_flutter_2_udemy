import 'dart:async';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:platform/platform.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  setUpAll(() async {
    final robotoFont = _loadMaterialFont('roboto-regular.ttf');

    final FontLoader fontLoader = FontLoader('Roboto')..addFont(robotoFont);
    await fontLoader.load();
  });

  await testMain();
}

Future<ByteData> _loadMaterialFont(String fontName) async {
  const FileSystem fs = LocalFileSystem();
  const Platform platform = LocalPlatform();

  final Directory flutterRoot =
      fs.directory(platform.environment['FLUTTER_ROOT']!);

  final File font = flutterRoot.childFile(
      fs.path.join('bin', 'cache', 'artifacts', 'material_fonts', fontName));

  final Future<ByteData> bytes =
      Future<ByteData>.value(font.readAsBytesSync().buffer.asByteData());

  return bytes;
}
