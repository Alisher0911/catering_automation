part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryLoading extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  const CategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoryError extends CategoryState {
  final String error;

  const CategoryError(this.error);

  @override
  List<Object?> get props => [error];

  @override
  String toString() => 'CategoryFailure { error: $error }';
}
