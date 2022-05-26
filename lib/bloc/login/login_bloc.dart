import 'package:bloc/bloc.dart';
import 'package:catering/bloc/authentication/authentication_bloc.dart';
import 'package:catering/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  // final CategoryBloc categoryBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
    // required this.categoryBloc
  }) : super(LoginInitial()) {
        on<LoginButtonPressed>(_onLoginButtonPressed);
      }


  void _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final token = await userRepository.login(
        event.email,
        event.password,
      );
      authenticationBloc.add(LoggedIn(token: token));
      // categoryBloc.add(LoadCategories(token: token));
      emit(LoginInitial());
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
