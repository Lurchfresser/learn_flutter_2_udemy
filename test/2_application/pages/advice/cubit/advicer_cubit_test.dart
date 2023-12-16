import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:learn_flutter_2_udemy/1_domain/entities/advice_entity.dart';
import 'package:learn_flutter_2_udemy/1_domain/failures/failures.dart';
import 'package:learn_flutter_2_udemy/1_domain/usecases/advice_usecases.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAdviceUseCase extends Mock implements AdviceUsecases {}

void main() {
  group('AdvicerCubit', () {
    group('should emit', () {
      MockAdviceUseCase mockAdviceUseCase = MockAdviceUseCase();

      blocTest(
        'nothing when no method is called',
        build: () => AdvicerCubit(adviceUsecases: mockAdviceUseCase),
        expect: () => const <AdvicerCubitState>[],
      );

      blocTest(
        '[AdvicerStateLoading, AdvicerStateLoaded] when adviceRequested() is called',
        setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
          (invocation) => Future.value(
            const Right<Failure, AdviceEntity>(
              AdviceEntity(advice: "fakeAdvice", 42),
            ),
          ),
        ),
        build: () => AdvicerCubit(adviceUsecases: mockAdviceUseCase),
        act: (bloc) => bloc.adviceRequested(),
        expect: () => <AdvicerCubitState>[
          AdvicerStateLoading(),
          const AdvicerStateLoaded(advice: "fakeAdvice"),
        ],
      );

      group(
        '[AdvicerStateLoading, AdvicerStateError] when adviceRequested() is called',
        () {
          blocTest(
            'and a Serverfailure occurs',
            build: () => AdvicerCubit(adviceUsecases: mockAdviceUseCase),
            setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                Left<Failure, AdviceEntity>(
                  ServerFailure(),
                ),
              ),
            ),
            act: (bloc) => bloc.adviceRequested(),
            expect: () => <AdvicerCubitState>[
              AdvicerStateLoading(),
              const AdvicerStateError(message: serverFailureMessage),
            ],
          );
          blocTest(
            'and a CacheFailure occurs',
            build: () => AdvicerCubit(adviceUsecases: mockAdviceUseCase),
            setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                Left<Failure, AdviceEntity>(
                  CacheFailure(),
                ),
              ),
            ),
            act: (bloc) => bloc.adviceRequested(),
            expect: () => <AdvicerCubitState>[
              AdvicerStateLoading(),
              const AdvicerStateError(message: cacheFailureMessage),
            ],
          );
          blocTest(
            'and a GeneralFailure occurs',
            build: () => AdvicerCubit(adviceUsecases: mockAdviceUseCase),
            setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                Left<Failure, AdviceEntity>(
                  GeneralFailure(),
                ),
              ),
            ),
            act: (bloc) => bloc.adviceRequested(),
            expect: () => <AdvicerCubitState>[
              AdvicerStateLoading(),
              const AdvicerStateError(message: generalFailureMessage),
            ],
          );
        },
      );
    });
  });
}
