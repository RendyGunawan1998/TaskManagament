import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthDataSource authDataSource;

  AuthBloc({required this.authDataSource}) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await authDataSource.login(event.email, event.password);

      emit(AuthAuthenticated(token: response.token));
    } catch (error) {
      emit(AuthError(message: 'Login failed: $error'));
    }
  }

  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    print('call register event');
    try {
      final response = await authDataSource.register(
          event.email, event.password, event.username);
      emit(AuthAuthenticated(token: response.token));
    } catch (error) {
      emit(AuthError(message: 'Registration failed: $error'));
    }
  }
}
