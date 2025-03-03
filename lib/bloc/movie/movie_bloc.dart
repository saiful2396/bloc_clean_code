import 'package:bloc/bloc.dart';
import 'package:bloc_clean_code/data/response/api_response.dart';
import 'package:bloc_clean_code/model/movie/movies_model.dart';
import 'package:bloc_clean_code/repository/movie/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieRepository movieRepository;

  MovieBloc({required this.movieRepository})
      : super(MovieState(movieList: APIResponse.loading())) {
    on<MoviesFetch>(_fetchMoviesApi);
  }

  Future<void> _fetchMoviesApi(
      MoviesFetch event, Emitter<MovieState> emit) async {
    emit(
      state.copyWith(movieList: APIResponse.loading()),
    );

    await movieRepository.fetchMovieList().then((value) async {
      emit(state.copyWith(movieList: APIResponse.completed(value)));
    }).onError((error, stackTrace) {
      emit(state.copyWith(movieList: APIResponse.error(error.toString())));
    });
  }
}
