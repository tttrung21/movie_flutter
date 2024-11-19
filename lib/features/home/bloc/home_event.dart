part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeStartedEvent extends HomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadMore extends HomeEvent{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class HomeRefreshEvent extends HomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
