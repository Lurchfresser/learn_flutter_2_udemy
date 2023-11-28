import 'package:dartz/dartz.dart';
import 'package:learn_flutter_2_udemy/0_data/datasources/advice_remote_datasource.dart';
import 'package:learn_flutter_2_udemy/0_data/exceptions/exeptions.dart';
import 'package:learn_flutter_2_udemy/1_domain/entities/advice_entity.dart';
import 'package:learn_flutter_2_udemy/1_domain/failures/failures.dart';
import 'package:learn_flutter_2_udemy/1_domain/repositories/advice_repo.dart';

class AdviceRepoImpl implements AdviceRepo{
  final AdviceRemoteDatasource adviceRemoteDatasource;

  AdviceRepoImpl({required this.adviceRemoteDatasource});

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource() async{
    try{
    final result = await adviceRemoteDatasource.getRandomAdviceFromApi();
    return right(result);
    } on ServerException catch(_){
      return left(ServerFailure());
    } 
    catch(e){
      return left(GeneralFailure());
    }
  }
}