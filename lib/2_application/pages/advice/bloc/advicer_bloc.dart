import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  AdvicerBloc() : super(AdvicerInitial()) {
    on<AdviceRequestedEvent>((event, emit) async {
      emit(AdvicerStateLoading());
      //business logic
      //for example: get advice from api
      debugPrint("fakeAdvice triggert from api");

      await Future.delayed(const Duration(seconds: 2), () {});

      debugPrint("got fakeAdvice from api");
      emit(AdvicerStateLoaded(advice: "fakeAdvice"));
    });
  }
}
