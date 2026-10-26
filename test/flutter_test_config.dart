import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> testExecutable(Future<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await _loadFamily('Montserrat', const [
    'assets/fonts/Montserrat-Medium.ttf',
    'assets/fonts/Montserrat-SemiBold.ttf',
    'assets/fonts/Montserrat-Bold.ttf',
    'assets/fonts/Montserrat-ExtraBold.ttf',
    'assets/fonts/Montserrat-Black.ttf',
  ]);
  await _loadFamily('Inter', const [
    'assets/fonts/Inter-Light.ttf',
    'assets/fonts/Inter-LightItalic.ttf',
    'assets/fonts/Inter-Regular.ttf',
    'assets/fonts/Inter-Italic.ttf',
    'assets/fonts/Inter-Medium.ttf',
    'assets/fonts/Inter-SemiBold.ttf',
  ]);
  await testMain();
}

Future<void> _loadFamily(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final file in files) {
    final bytes = File(file).readAsBytesSync();
    loader.addFont(
      Future<ByteData>.value(ByteData.sublistView(Uint8List.fromList(bytes))),
    );
  }
  await loader.load();
}
