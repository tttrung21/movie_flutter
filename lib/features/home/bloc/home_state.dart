part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState{}

class HomeSuccess extends HomeState{
  final List<Results> listMovies;
  final bool hasMore;
  const HomeSuccess(this.listMovies,this.hasMore);
  @override
  // TODO: implement props
  List<Object> get props => [listMovies,hasMore];
}

class HomeError extends HomeState{
  final String error;
  const HomeError(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}