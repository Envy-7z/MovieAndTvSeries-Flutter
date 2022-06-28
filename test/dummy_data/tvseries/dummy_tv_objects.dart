
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';


final testTv = TvShow(
    backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
    genreIds: [10765, 35, 80],
    id: 90462,
    name: "Chucky",
    originalName: "Chucky",
    overview:
        "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
    popularity: 6858.77,
    posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
    voteAverage: 8,
    voteCount: 1418);

final testTvList = [testTv];

final testTvDetail = TvDetail(
    backdropPath: "backdropPath",
    genres: [Genre(id: 1, name: "Action")],
    id: 1,
    name: "name",
    originalName: "originalName",
    overview: "overview",
    posterPath: "posterPath",
    voteAverage: 1,
    voteCount: 1, episodeRunTime: [1,2,3]);

final testWatchlistTv = TvShow.watchlist(
    id: 1, overview: "overview", posterPath: "posterPath", name: "name");

final testTvTable = TvTable(
    id: 1, name: "name", posterPath: "posterPath", overview: "overview");

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name'
};
