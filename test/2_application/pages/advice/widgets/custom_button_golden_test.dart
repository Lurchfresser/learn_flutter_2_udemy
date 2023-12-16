import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/widgets/custom_button.dart';

Widget widgetUnderTest(VoidCallback? onTap) {
  return MaterialApp(
    home: Scaffold(
      body: CustomButton(
        onTap: onTap,
      ),
    ),
  );
}

void main() {
  group('Golden Test', () {
    group('Custom Button', () {
      testWidgets(
        'is enabled',
        (widgetTester) async {
          await widgetTester.pumpWidget(widgetUnderTest(() {}));
          
          await expectLater(
            find.byType(CustomButton),
            matchesGoldenFile('goldens/custom_button_enabled.png'),
          );
        },
      );
      testWidgets(
        'is disabled',
        (widgetTester) async {
          await widgetTester.pumpWidget(widgetUnderTest(null));
          
          await expectLater(
            find.byType(CustomButton),
            matchesGoldenFile('goldens/custom_button_disabled.png'),
          );
        },
      );
    });
  });
}
