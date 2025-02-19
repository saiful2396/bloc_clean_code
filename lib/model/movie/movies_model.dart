import 'package:freezed_annotation/freezed_annotation.dart';
part 'movies_model.freezed.dart';
part 'movies_model.g.dart';
@freezed
class MoviesModel with _$MoviesModel {
  factory MoviesModel({
    @Default('') String total,
    @Default(0) int page,
    @Default(0) int pages,
    @Default([]) List<TvShows> tvShow,
  }) = _MoviesModel;

  factory MoviesModel.fromJson(Map<String, dynamic> json) =>
      _$MoviesModelFromJson(json);
}

@freezed
class TvShows with _$TvShows {
  factory TvShows({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String permalink,
    @Default('') String startDate,
    @Default('') String endDate,
    @Default('') String country,
    @Default('') String network,
    @Default('') String status,
    @Default('') String imageThumbnailPath,
  }) = _TvShows;

  factory TvShows.fromJson(Map<String, dynamic> json) =>
      _$TvShowsFromJson(json);
}
