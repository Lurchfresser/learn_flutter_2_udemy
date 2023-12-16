import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/widgets/advice_field.dart';

Widget widgetUnderTest(String text) {
  return MaterialApp(
    home: AdviceField(advice: text),
  );
}

void main() {
  group('AdviceField', () {
    group('should be displayed correctly', () {
      testWidgets('when short text is given', (widgetTester) async {
        const text = 'a';

        await widgetTester.pumpWidget(widgetUnderTest(text));
        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.byType(AdviceField);

        expect(adviceFieldFinder, findsOneWidget);
      });
      testWidgets('when long text is given', (widgetTester) async {
        final text = 'a' * 1000;

        await widgetTester.pumpWidget(widgetUnderTest(text));
        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.textContaining(text);

        expect(adviceFieldFinder, findsOneWidget);
      });
    });
    testWidgets('when no text is given', (widgetTester) async {
        const text = '';

        await widgetTester.pumpWidget(widgetUnderTest(text));
        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.byType(AdviceField);

        expect(adviceFieldFinder, findsOneWidget);
      });
  });
}
