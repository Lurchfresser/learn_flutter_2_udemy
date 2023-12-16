import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/widgets/custom_button.dart';
import 'package:mockito/mockito.dart';


Widget widgetUnderTest(Function? onTap) {
  return MaterialApp(
    home: Scaffold(
      body: CustomButton(onTap: onTap,),
    ),
  );
}

abstract class FakeFunction {
  void call();
}

class MockFakeFunction extends Mock implements FakeFunction {}

void main() {
  group('custom Button', () {
    group('is Button rendered correctly', () {
      testWidgets(
        'test name',
        (tester) async {
          await tester.pumpWidget(widgetUnderTest((){}));
          await tester.pumpAndSettle();

          final buttonLabelFinder = find.text('Get Advice');

          expect(buttonLabelFinder, findsOneWidget);
        },
      );
    });
    group('should handle callback', () {
      testWidgets(
        'when button is pressed',
        (widgetTester) async {
          final mockFakeFunction = MockFakeFunction();

          await widgetTester.pumpWidget(widgetUnderTest(mockFakeFunction.call));
          await widgetTester.pumpAndSettle();

          final customButtonFinder = find.byType(CustomButton);

          widgetTester.tap(customButtonFinder);

          verify(mockFakeFunction()).called(1);
        },
      );
    });
  });
}
