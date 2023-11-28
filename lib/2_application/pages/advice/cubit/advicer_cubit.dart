import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_flutter_2_udemy/1_domain/entities/advice_entity.dart';
import 'package:learn_flutter_2_udemy/1_domain/failures/failures.dart';
import 'package:learn_flutter_2_udemy/1_domain/usecases/advice_usecases.dart';

part 'advicer_state.dart';


//maybe exclude this later
const serverFailureMessage = "Server Failure";
const cacheFailureMessage = "Cache Failure";
const generalFailureMessage = "OOps, something went wrong";

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  AdvicerCubit() : super(AdvicerInitial());
  final AdviceUsecases adviceUsecases = AdviceUsecases();
  //could also use multiple usecases

  void adviceRequested() async {
    emit(AdvicerStateLoading());
    //business logic
    final  failurOrAdvice = await adviceUsecases.getAdvice();
    failurOrAdvice.fold(
      (failure) => emit(AdvicerStateError(message: _mapFailureToMessage(failure))),
      (advice) => emit(AdvicerStateLoaded(advice: advice.advice)),
    );
  }

  //maybe exclude this later
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return serverFailureMessage;
      case const (CacheFailure):
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
