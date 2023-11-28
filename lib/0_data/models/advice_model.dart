import 'package:equatable/equatable.dart';
import 'package:learn_flutter_2_udemy/1_domain/entities/advice_entity.dart';

class AdviceModel extends AdviceEntity with EquatableMixin {
  AdviceModel({
    required String advice,
    required int id,
  }):super(advice: advice,id);

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      advice: json['advice'],
      id: json['advice_id'],
    );
  }
}
