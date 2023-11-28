import 'package:dartz/dartz.dart';
import 'package:learn_flutter_2_udemy/1_domain/entities/advice_entity.dart';
import 'package:learn_flutter_2_udemy/1_domain/failures/failures.dart';

abstract class AdviceRepo {
  Future<Either<Failure,AdviceEntity>> getAdviceFromDatasource();
}