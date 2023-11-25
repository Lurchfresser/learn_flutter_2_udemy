import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_flutter_2_udemy/1_domain/entities/advice_entity.dart';
import 'package:learn_flutter_2_udemy/1_domain/usecases/advice_usecases.dart';

part 'advicer_state.dart';

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  AdvicerCubit() : super(AdvicerInitial());
  final AdviceUsecases adviceUsecases = AdviceUsecases();
  //could also use multiple usecases

  void adviceRequested() async {
    emit(AdvicerStateLoading());
    //business logic
    final AdviceEntity advice = await adviceUsecases.getAdvice();
    //emit(const AdvicerStateError(message: "Error"));
    emit(AdvicerStateLoaded(advice: advice.advice));
  }
}
