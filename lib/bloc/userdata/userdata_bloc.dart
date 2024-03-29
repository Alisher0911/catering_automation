import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catering/bloc/authentication/authentication_bloc.dart';
import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/models/user_model.dart';
import 'package:catering/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'userdata_event.dart';
part 'userdata_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  final BasketBloc basketBloc;
  StreamSubscription? _userSubscription;

  UserDataBloc({
    required this.userRepository,
    required this.authenticationBloc,
    required this.basketBloc
  }) : super(UserDataLoading()) {
    on<LoadUserData>(_onLoadUserData);
  }

  void _onLoadUserData(LoadUserData event, Emitter<UserDataState> emit) async {
    _userSubscription?.cancel();
    emit(UserDataLoading());
    try {
      bool isSignedIn = await userRepository.hasToken();
      if (isSignedIn) {
        final user = await userRepository.getUserInformation();
        emit(UserDataLoaded(user));
      } else {
        authenticationBloc.add(LoggedOut());
        basketBloc.add(ClearBasket());
        emit(UserDataError("No token"));
      }
    } catch(e) {
      authenticationBloc.add(LoggedOut());
      basketBloc.add(ClearBasket());
      emit(UserDataError(e.toString()));
    }
  }


  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
