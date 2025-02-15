part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

// Loading states

class HomeGeneralLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

// initial state when bloc is created
class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

// success states
class HomeSuccess extends HomeState {
  final BannerEntity bannerEntity;
  final CardEntity cardEntity;

  HomeSuccess({required this.bannerEntity, required this.cardEntity});

  @override
  List<Object?> get props => [];
}

// error state
class HomeError extends HomeState {
  final String errorMessage;

  HomeError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
