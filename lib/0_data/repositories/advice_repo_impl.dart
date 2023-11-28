import 'package:dartz/dartz.dart';
import 'package:learn_flutter_2_udemy/0_data/datasources/advice_remote_datasource.dart';
import 'package:learn_flutter_2_udemy/1_domain/entities/advice_entity.dart';
import 'package:learn_flutter_2_udemy/1_domain/failures/failures.dart';
import 'package:learn_flutter_2_udemy/1_domain/repositories/advice_repo.dart';

class AdviceRepoImpl implements AdviceRepo{

  final adviceRemoteDatasource = AdviceRemoteDatasourceImpl();
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource() async{
    final result = await adviceRemoteDatasource.getRandomAdviceFromApi();
    return right(result);
  }
}