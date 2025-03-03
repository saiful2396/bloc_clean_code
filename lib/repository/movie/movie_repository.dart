import 'package:bloc_clean_code/model/movie/movies_model.dart';

abstract class MovieRepository {
  Future<MoviesModel> fetchMovieList();
}