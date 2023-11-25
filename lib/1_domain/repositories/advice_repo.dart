import 'package:learn_flutter_2_udemy/1_domain/entities/advice_entity.dart';

abstract class AdviceRepo {
  Future<AdviceEntity> getAdviceFromDatasource();
}