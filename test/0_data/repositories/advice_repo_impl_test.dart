import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:learn_flutter_2_udemy/0_data/datasources/advice_remote_datasource.dart';
import 'package:learn_flutter_2_udemy/0_data/exceptions/exeptions.dart';
import 'package:learn_flutter_2_udemy/0_data/models/advice_model.dart';
import 'package:learn_flutter_2_udemy/0_data/repositories/advice_repo_impl.dart';
import 'package:learn_flutter_2_udemy/1_domain/entities/advice_entity.dart';
import 'package:learn_flutter_2_udemy/1_domain/failures/failures.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'advice_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDatasourceImpl>()])
void main() {
  group('AdviceRepoImpl', () {
    group('Should return AdviceEntity', () {
      test('when remote datasource returns AdviceModel', () async {
        final mockRemoteDatasource = MockAdviceRemoteDatasourceImpl();
        final adviceRepoImplUnderTest =
            AdviceRepoImpl(adviceRemoteDatasource: mockRemoteDatasource);

        when(mockRemoteDatasource.getRandomAdviceFromApi())
            .thenAnswer((realInvocation) => Future.value(AdviceModel(
                  advice: 'test',
                  id: 42,
                )));

        final result = await adviceRepoImplUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
            result,
             Right<Failure, AdviceEntity>(AdviceModel(
              id: 42,
              advice: 'test',
            )));
        verify(mockRemoteDatasource.getRandomAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockRemoteDatasource);
      });
    });
    group('should return left with', (){
      test('ServerFailure when remote datasource throws ServerException', () async {
        final mockRemoteDatasource = MockAdviceRemoteDatasourceImpl();
        final adviceRepoImplUnderTest =
            AdviceRepoImpl(adviceRemoteDatasource: mockRemoteDatasource);

        when(mockRemoteDatasource.getRandomAdviceFromApi())
            .thenThrow(ServerException());

        final result = await adviceRepoImplUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(
            result,
            Left<Failure, AdviceEntity>(
                ServerFailure()));
        verify(mockRemoteDatasource.getRandomAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockRemoteDatasource);
      });
      
      test('Generalfailure on all other exceptions', () async {
        final mockRemoteDatasource = MockAdviceRemoteDatasourceImpl();
        final adviceRepoImplUnderTest =
            AdviceRepoImpl(adviceRemoteDatasource: mockRemoteDatasource);

        when(mockRemoteDatasource.getRandomAdviceFromApi())
            .thenThrow(const SocketException('test'));

        final result = await adviceRepoImplUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(
            result,
            Left<Failure, AdviceEntity>(
                GeneralFailure()));
        verify(mockRemoteDatasource.getRandomAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockRemoteDatasource);
      });
    });
  });
}
