import 'package:equatable/equatable.dart';

import '../../models/user.dart';

class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props=>[];
}
class AuthInitial extends AuthState{}
class AuthLoading extends AuthState{}
class AuthRegistered extends AuthState{}
class AuthSuccess extends AuthState{
  final String token;
  final User? user;
  const AuthSuccess(
    {
      required this.token,
      required this.user,
    }
  );
  @override
  List<Object?> get props=>[token,user];
}
class AuthFailure extends AuthState
{
  final String message;
  const AuthFailure({required this.message});
  @override
  List<Object?> get props=>[message];
}