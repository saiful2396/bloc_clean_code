part of 'movie_bloc.dart';

class MovieState extends Equatable {
  const MovieState({required this.movieList});

  final APIResponse<MoviesModel> movieList;

  MovieState copyWith({APIResponse<MoviesModel>? movieList}) {
    return MovieState(movieList: movieList ?? this.movieList);
  }

  @override
  List<Object?> get props => [movieList];
}
