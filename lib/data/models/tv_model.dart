import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  String? posterPath;
  double? popularity;
  int? id;
  String? backdropPath;
  double? voteAverage;
  String? overview;
  String? firstAirDate;
  List<int>? genreIds;
  int? voteCount;
  String? name;
  String? originalName;

  TvSeriesModel({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.genreIds,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        id: json["id"],
        backdropPath: json["backdrop_path"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        firstAirDate: json["first_air_date"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "popularity": popularity,
        "id": id,
        "backdrop_path": backdropPath,
        "vote_average": voteAverage,
        "overview": overview,
        "first_air_date": firstAirDate,
        "genre_ids": genreIds,
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
      };

  TvShow toEntity() {
    return TvShow(
      posterPath: this.posterPath,
      popularity: this.popularity,
      id: this.id,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      overview: overview,
      genreIds: genreIds,
      voteCount: voteCount,
      name: name,
      originalName: originalName,
    );
  }

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        genreIds,
        voteCount,
        name,
        originalName,
      ];
}
