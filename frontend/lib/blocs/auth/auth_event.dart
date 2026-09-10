import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable
{
  const AuthEvent();
  List<Object?> get props=>[]; //this i use for comparing
}
class LoginButtonPressed extends AuthEvent{
  final String email;
  final String password;
  const LoginButtonPressed({
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props=>[email,password];//using email and password to compare for login
}
class RegisterButtonPressed extends AuthEvent{
  final String email;
  final String password;
  final String name;
  const RegisterButtonPressed(
    {
      required this.email,
      required this.password,
      required this.name,
    }
  );
  @override
  List<Object?> get props=>[email,password,name];
}
class LogoutButtonPressed extends AuthEvent
{
  
}