import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String errorMessage;
  final DateTime? timestamp;

  RegisterFailure({
    required this.errorMessage,
    this.timestamp,
  });

  @override
  List<Object> get props => [timestamp ?? DateTime.now()];
}

class RegisterLoading extends RegisterState {}

class RegisterStopLoading extends RegisterState {}
