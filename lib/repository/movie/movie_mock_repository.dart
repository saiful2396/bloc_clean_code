import 'package:bloc_clean_code/model/movie/movies_model.dart';
import 'package:bloc_clean_code/repository/movie/movie_repository.dart';

class MovieMockRepository implements MovieRepository {
  @override
  Future<MoviesModel> fetchMovieList() async {
    await Future.delayed(const Duration(seconds: 2));

    var response = {'token': 'a23z345xert'};

    return MoviesModel.fromJson(response);
  }
}
