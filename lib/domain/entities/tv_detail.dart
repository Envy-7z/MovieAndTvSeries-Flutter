import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.genres,
      required this.id,
      required this.name,
      required this.originalName,
      required this.overview,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount,
      required this.numberOfSeasons});

  TvDetail.watchlist(
      {required this.id,
      required this.overview,
      required this.posterPath,
      required this.name,
      required this.voteCount,
      required this.voteAverage,
      required this.genres,
      required this.numberOfSeasons});

  String? backdropPath;
  String? firstAirDate;
  List<Genre> genres;
  int id;
  String name;
  String? originalName;
  String overview;
  String? posterPath;
  double voteAverage;
  int voteCount;
  int numberOfSeasons;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        id,
        name,
        originalName,
        overview,
        posterPath,
        voteAverage,
        voteCount,
        numberOfSeasons,
      ];
}
