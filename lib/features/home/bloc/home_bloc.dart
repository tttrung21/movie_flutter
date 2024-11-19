import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_movie_app/api_service/api_service.dart';
import 'package:simple_movie_app/model/list_movie_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService apiService;
  int page = 1;
  HomeBloc(this.apiService) : super(HomeInitial()) {
    on<HomeStartedEvent>(_onInit);
    on<LoadMore>(_onLoadMore);
    on<HomeRefreshEvent>(_onRefresh);
  }

  Future<void> _onInit(HomeStartedEvent event, Emitter<HomeState> emit) async{
    emit(HomeLoading());
    try{
      final List<Results> newMovies = await apiService.fetchMovies(page: page);
      page++;
      emit(HomeSuccess(newMovies, newMovies.isNotEmpty));
    }
    catch(e){
      emit(HomeError(e.toString()));
    }
  }
  Future<void> _onLoadMore(LoadMore event, Emitter<HomeState> emit) async{
    try{

      final List<Results> currentMovies = state is HomeSuccess ? (state as HomeSuccess).listMovies : [];
      final List<Results> newMovies = await apiService.fetchMovies(page: page);
      final List<Results> listMovies = currentMovies + newMovies;
      page++;
      emit(HomeSuccess(listMovies, newMovies.isNotEmpty));
    }
    catch(e){
      emit(HomeError(e.toString()));
    }
  }
  Future<void> _onRefresh(HomeRefreshEvent event, Emitter<HomeState> emit) async{
    emit(HomeLoading());
    try{
      page = 1;
      final List<Results> movies = await apiService.fetchMovies(page: page);
      page++;
      emit(HomeSuccess(movies, movies.isNotEmpty));
    }
    catch(e){
      emit(HomeError(e.toString()));
    }
  }
}
