import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'qr_event.dart';
part 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  QrBloc() : super(DataLoading()) {
    on<ShowCamera>(_onShowCamera);
  }

  void _onShowCamera(ShowCamera event, Emitter<QrState> emit) async {
    
  }
}