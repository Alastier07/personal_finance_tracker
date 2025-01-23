import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class LogoutFailure extends AuthState {
  final String errorMessage;
  final DateTime? timestamp;

  LogoutFailure({
    required this.errorMessage,
    this.timestamp,
  });

  @override
  List<Object> get props => [timestamp ?? DateTime.now()];
}
