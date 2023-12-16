import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter_2_udemy/2_application/core/services/theme_service.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/advice_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/widgets/advice_field.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/widgets/error_message.dart';
import 'package:provider/provider.dart';

class MockAdvicerCubit extends MockCubit<AdvicerCubitState>
    implements AdvicerCubit {}

Widget widgetUnderTest({required AdvicerCubit cubit}) {
  return MaterialApp(
    home: ChangeNotifierProvider(
      create: (context) => ThemeService(),
      child: BlocProvider(
        create: (context) => cubit,
        child: const AdvicePage(),
      ),
    ),
  );
}

void main() {
  group('AdvicerPage', () {
    late AdvicerCubit mockAdvicerCubit;

    setUp(() {
      mockAdvicerCubit = MockAdvicerCubit();
    });
    group('should be displayed in ViewState', () {
      testWidgets(
        'Initial when cubit emits AdvicerInitialState',
        (widgetTester) async {
          whenListen(
            mockAdvicerCubit,
            Stream.fromIterable([AdvicerInitial()]),
            initialState: AdvicerInitial(),
          );

          await widgetTester
              .pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
          await widgetTester.pumpAndSettle();

          final advicerInitialTextFinder =
              find.text('Your Advice will be here');

          expect(advicerInitialTextFinder, findsOneWidget);
        },
      );
      testWidgets(
        'Loading when cubit emits AdvicerStateLoading',
        (widgetTester) async {
          whenListen(
            mockAdvicerCubit,
            Stream.fromIterable([AdvicerStateLoading()]),
            initialState: AdvicerInitial(),
          );

          await widgetTester
              .pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
          await widgetTester.pump();

          final advicerLoadingFinder = find.byType(CircularProgressIndicator);

          expect(advicerLoadingFinder, findsOneWidget);
        },
      );
      testWidgets(
        'advice text when cubit emits AdvicerStateLoaded',
        (widgetTester) async {
          whenListen(
            mockAdvicerCubit,
            Stream.fromIterable([const AdvicerStateLoaded(advice: 'test')]),
            initialState: AdvicerInitial(),
          );

          await widgetTester
              .pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
          await widgetTester.pump();

          final advicerLoadedFinder = find.byType(AdviceField);
          final advicetext = widgetTester.widget<AdviceField>(advicerLoadedFinder).advice;

          expect(advicerLoadedFinder, findsOneWidget);
          expect(advicetext, 'test');
        },
      );
      testWidgets(
        'Error when cubit emits AdvicerStateError',
        (widgetTester) async {
          whenListen(
            mockAdvicerCubit,
            Stream.fromIterable([const AdvicerStateError(message: 'test')]),
            initialState: AdvicerInitial(),
          );

          await widgetTester
              .pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
          await widgetTester.pump();

          final advicerErrorFinder = find.byType(ErrorMessage);
          final errorText = widgetTester.widget<ErrorMessage>(advicerErrorFinder).message;

          expect(advicerErrorFinder, findsOneWidget);
          expect(errorText, 'test');
        },
      );
    });
  });
}
