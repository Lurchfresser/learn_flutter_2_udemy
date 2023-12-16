

import 'package:dartz/dartz.dart';
import 'package:learn_flutter_2_udemy/0_data/models/advice_model.dart';
import 'package:learn_flutter_2_udemy/0_data/repositories/advice_repo_impl.dart';
import 'package:learn_flutter_2_udemy/1_domain/entities/advice_entity.dart';
import 'package:learn_flutter_2_udemy/1_domain/failures/failures.dart';
import 'package:learn_flutter_2_udemy/1_domain/usecases/advice_usecases.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'advice_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepoImpl>()])
void main() {
  group('AdviceUsecases', () {
    group('Should return AdviceEntity', () {
      test('when AdviceRepoImpl returns AdviceModel', () async {
        final mockAdviceRepo = MockAdviceRepoImpl();
        final adviceUseCasesUnderTest =
            AdviceUsecases(adviceRepo: mockAdviceRepo);

        when(mockAdviceRepo.getAdviceFromDatasource())
            .thenAnswer((realInvocation) => Future.value(Right(AdviceModel(
                  advice: 'test',
                  id: 42,
                ))));

        final result = await adviceUseCasesUnderTest.getAdvice();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
            result,
            Right<Failure, AdviceEntity>(AdviceModel(
              id: 42,
              advice: 'test',
            )));
        verify(mockAdviceRepo.getAdviceFromDatasource()).called(1);
      });
    });
    group('should return left with', () {
      test('a ServerFailure', () async {
        final mockAdviceRepo = MockAdviceRepoImpl();
        final adviceUseCasesUnderTest =
            AdviceUsecases(adviceRepo: mockAdviceRepo);

        when(mockAdviceRepo.getAdviceFromDatasource())
            .thenAnswer((realInvocation) => Future.value(Left(ServerFailure())));

        final result = await adviceUseCasesUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result,Left<Failure, AdviceEntity>(ServerFailure()));
        verify(mockAdviceRepo.getAdviceFromDatasource()).called(1);
      });

      test('Generalfailure on all other exceptions', () async {
        final mockAdviceRepo = MockAdviceRepoImpl();
        final adviceUseCasesUnderTest =
            AdviceUsecases(adviceRepo: mockAdviceRepo);

        when(mockAdviceRepo.getAdviceFromDatasource())
            .thenAnswer((realInvocation) => Future.value(Left(GeneralFailure())));

        final result = await adviceUseCasesUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result,Left<Failure, AdviceEntity>(GeneralFailure()));
        verify(mockAdviceRepo.getAdviceFromDatasource()).called(1);
      });
    });
  });
}
