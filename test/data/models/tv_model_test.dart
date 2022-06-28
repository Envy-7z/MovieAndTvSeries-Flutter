import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvShowModel = TvSeriesModel(
      genreIds: [1, 2, 3],
      backdropPath: 'backdropPath',
      id: 1,
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1,
      name: 'name',
      originalName: 'originalName',
      firstAirDate: '');

  final tTvShow = TvShow(
      backdropPath: "backdropPath",
      genreIds: [1, 2, 3],
      id: 1,
      name: "name",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 1,
      voteCount: 1);

  test('should be a subclass of Tv Series entity', () async {
    final result = tTvShowModel.toEntity();
    expect(result, tTvShow);
  });
}
