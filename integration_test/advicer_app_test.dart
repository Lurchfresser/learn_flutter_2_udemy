import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/widgets/advice_field.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/widgets/custom_button.dart';
import 'package:learn_flutter_2_udemy/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
      'tap on custom button, verify advice will be loaded',
      (widgetTester) async {
        app.main();
        await widgetTester.pumpAndSettle();

        //verify that no advice is loaded
        expect(find.text('Your Advice will be here'), findsOneWidget);

        // Find custom button
        final customButtonFinder = find.byType(CustomButton);

        // Tap on custom button
        await widgetTester.tap(customButtonFinder);

        // Trigger a frame and wait until its settled
        await widgetTester.pumpAndSettle();

        // Verify that advice was loaded
        expect(find.byType(AdviceField), findsOneWidget);

      },
    );
  });
}
