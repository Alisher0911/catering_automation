import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:catering/config/secure_storage.dart';
import 'package:catering/models/category_model.dart';
import 'package:catering/repositories/category_repository.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  StreamSubscription? _categorySubscription;
  final storage = SecureStorageService.getInstance;

  CategoryBloc({
    required this.categoryRepository
  }) : super(CategoryLoading()) {
    on<LoadCategories>(_onLoadCategories);
  }

  void _onLoadCategories(LoadCategories event, Emitter<CategoryState> emit) async {
    _categorySubscription?.cancel();
    emit(CategoryLoading());
    try {
      bool isSignedIn = await storage.containsKey(key: "token");
      if (isSignedIn) {
        final categories = await categoryRepository.getCategories();
        emit(CategoryLoaded(categories));
      } else {
        emit(CategoryError("No token"));
      }
    } catch(e) {
      emit(CategoryError(e.toString()));
    }
  }
}
