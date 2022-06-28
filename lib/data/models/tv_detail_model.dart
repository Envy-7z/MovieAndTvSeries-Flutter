import 'package:ditonton/data/models/genre_model.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_detail.dart';

class TvDetailResponse extends Equatable {
  TvDetailResponse(
      {required this.backdropPath,
      this.firstAirDate,
      required this.genres,
      required this.id,
      required this.name,
      required this.originalName,
      required this.overview,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount,
      required this.numberOfSeasons});

  final String backdropPath;
  final firstAirDate;
  final List<GenreModel> genres;
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final int voteCount;
  final int numberOfSeasons;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
          backdropPath: json["backdrop_path"],
          firstAirDate: json["first_air_date"],
          genres: List<GenreModel>.from(
              json["genres"].map((x) => GenreModel.fromJson(x))),
          id: json["id"],
          name: json["name"],
          originalName: json["original_name"],
          overview: json["overview"],
          posterPath: json["poster_path"],
          voteAverage: json["vote_average"].toDouble(),
          voteCount: json["vote_count"],
          numberOfSeasons: json["number_of_seasons"]);

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "number_of_seasons": numberOfSeasons
      };

  TvDetail toEntity() {
    return TvDetail(
        backdropPath: this.backdropPath,
        firstAirDate: this.firstAirDate,
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        id: this.id,
        name: this.name,
        originalName: this.originalName,
        overview: this.overview,
        posterPath: this.posterPath,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount,
        numberOfSeasons: this.numberOfSeasons);
  }

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
        numberOfSeasons
      ];
}
