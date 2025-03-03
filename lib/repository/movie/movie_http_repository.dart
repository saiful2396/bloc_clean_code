import 'package:bloc_clean_code/model/movie/movies_model.dart';

import '../../config/app_url.dart';
import '../../data/network/network_services.dart';
import 'movie_repository.dart';

class MovieHttpRepository implements MovieRepository{
  final _api = NetworkServices();

  @override
  Future<MoviesModel> fetchMovieList() async {
    final response = await _api.getApi(AppUrl.movieListApi);
    return MoviesModel.fromJson(response);
  }
}