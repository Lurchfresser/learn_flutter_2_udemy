import 'package:get_it/get_it.dart';
import 'package:learn_flutter_2_udemy/0_data/datasources/advice_remote_datasource.dart';
import 'package:learn_flutter_2_udemy/0_data/repositories/advice_repo_impl.dart';
import 'package:learn_flutter_2_udemy/1_domain/repositories/advice_repo.dart';
import 'package:learn_flutter_2_udemy/1_domain/usecases/advice_usecases.dart';
import 'package:learn_flutter_2_udemy/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async{
  // ! apllication layer
  //Factory = everytime we call it, it will create a new instance
  sl.registerFactory(() => AdvicerCubit(adviceUsecases: sl()));

  // ! domain layer
  sl.registerFactory(() => AdviceUsecases(adviceRepo: sl()));

  // ! data layer
  sl.registerFactory<AdviceRepo>(() => AdviceRepoImpl(adviceRemoteDatasource: sl()));
  sl.registerFactory<AdviceRemoteDatasource>(() => AdviceRemoteDatasourceImpl(client: sl()));

  // ! external
  sl.registerFactory(() => http.Client());
}