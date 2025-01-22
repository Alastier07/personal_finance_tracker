import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginStopLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final DateTime? timestamp;
  final String errorMessage;

  LoginFailure({required this.errorMessage, this.timestamp});

  @override
  List<Object> get props => [timestamp ?? DateTime.now()];
}
