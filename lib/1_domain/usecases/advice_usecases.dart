import 'package:learn_flutter_2_udemy/1_domain/entities/advice_entity.dart';

class AdviceUsecases {
  Future<AdviceEntity> getAdvice() async {
    //call a repository to get data (fail or data)
    //proceed with business logic (manipulate the data)
    //for example: get advice from api
    await Future.delayed(const Duration(seconds: 2), () {});
    return const AdviceEntity(1, advice: "advice to test");
  }
}