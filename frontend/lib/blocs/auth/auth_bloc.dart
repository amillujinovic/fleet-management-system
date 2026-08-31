import 'package:fleet_management_app/blocs/auth/auth_event.dart';
import 'package:fleet_management_app/blocs/auth/auth_state.dart';
import 'package:fleet_management_app/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBlock extends Bloc<AuthEvent,AuthState>
{ 
  final AuthService _authService;
 AuthBlock({AuthService? authService})
      : _authService = authService ?? AuthService(),
        super(AuthInitial())
  {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }
  Future<void> _onLoginButtonPressed(LoginButtonPressed event,Emitter<AuthState> emit) async
  {emit(AuthLoading());
    try
    {
      final result= await _authService.login(event.email,event.password);
      emit(AuthSuccess(user: result.user,token: result.token));
    }
    catch(e)
    {
      emit(AuthFailure(message: e.toString()));
    }
  }
  Future<void> _onRegisterButtonPressed(RegisterButtonPressed event,Emitter<AuthState> emit) async
  {
    emit(AuthLoading());
    try
    {
      await _authService.Register(
       name: event.name,
       email: event.email,
       password: event.password,
       );
       emit(AuthRegistered());
    }
    catch(e)
    {
      emit(AuthFailure(message: e.toString()));
    }
  }
  Future<void> _onLogoutButtonPressed(LogoutButtonPressed event,Emitter<AuthState> emit) async
  {
    await _authService.logout();
    emit(AuthInitial());
  }
}