part of 'advicer_cubit.dart';

sealed class AdvicerCubitState extends Equatable {
  const AdvicerCubitState();

  @override
  List<Object?> get props => [];
}

final class AdvicerInitial extends AdvicerCubitState {}


class AdvicerStateLoading extends AdvicerCubitState {}

class AdvicerStateLoaded extends AdvicerCubitState {
  final String advice;

  @override
  List<Object?> get props => [advice];

  const AdvicerStateLoaded({required this.advice});
}

class AdvicerStateError extends AdvicerCubitState {
  final String message;

  @override
  List<Object?> get props => [message];

  const AdvicerStateError({required this.message});
}