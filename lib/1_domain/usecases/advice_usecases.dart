import 'package:dartz/dartz.dart';
import 'package:learn_flutter_2_udemy/0_data/repositories/advice_repo_impl.dart';
import 'package:learn_flutter_2_udemy/1_domain/entities/advice_entity.dart';
import 'package:learn_flutter_2_udemy/1_domain/failures/failures.dart';

class AdviceUsecases {
  final adviceRepo = AdviceRepoImpl();

  Future<Either<Failure,AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDatasource();

    //space for business logic



  }
}