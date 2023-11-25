import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'advicer_state.dart';

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  AdvicerCubit() : super(AdvicerInitial());

  void adviceRequested() async {
    emit(AdvicerStateLoading());
    //business logic
    //for example: get advice from api

    await Future.delayed(const Duration(seconds: 2), () {});

    //emit(const AdvicerStateError(message: "Error"));
    emit(const AdvicerStateLoaded(advice: "fakeAdvice"));
  }
}
