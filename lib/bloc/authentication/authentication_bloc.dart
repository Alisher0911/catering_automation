import 'package:bloc/bloc.dart';
import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  final BasketBloc basketBloc;

  AuthenticationBloc({
    required this.userRepository,
    required this.basketBloc
  }) : super(AuthenticationUninitialized()) {
        on<AppStarted>(_onAppStarted);
        on<LoggedIn>(_onLoggedIn);
        on<LoggedOut>(_onLoggedOut);
      }


  void _onAppStarted(AppStarted event, Emitter<AuthenticationState> emit) async {
    final bool hasToken = await userRepository.hasToken();
    if (hasToken) {
      emit(AuthenticationAuthenticated());
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    await userRepository.persistToken(event.token);
    emit(AuthenticationAuthenticated());
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    await userRepository.deleteToken();
    basketBloc.add(ClearBasket());
    emit(AuthenticationUnauthenticated());
  }
}