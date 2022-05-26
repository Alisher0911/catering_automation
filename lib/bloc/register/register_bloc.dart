import 'package:bloc/bloc.dart';
import 'package:catering/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegisterBloc({
    required this.userRepository
  }) : super(RegisterInitial()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }


  void _onRegisterButtonPressed(RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      await userRepository.register(
        event.email,
        event.username,
        event.password,
        event.confirmPassword
      );
      emit(RegisterSuccess());
    } catch (error) {
      emit(RegisterFailure(error: error.toString()));
    }
  }
}
