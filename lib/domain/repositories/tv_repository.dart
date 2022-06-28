import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<TvShow>>> getNowPlayingTv();

  Future<Either<Failure, List<TvShow>>> getPopularTv();

  Future<Either<Failure, List<TvShow>>> getTopRatedTv();

  Future<Either<Failure, TvDetail>> getTvDetail(int id);

  Future<Either<Failure, List<TvShow>>> getTvRecommendations(int id);

  Future<Either<Failure, List<TvShow>>> searchTv(String query);

  Future<Either<Failure, String>> saveWatchlist(TvDetail tv);

  Future<Either<Failure, String>> removeWatchlist(TvDetail tv);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, List<TvShow>>> getWatchlistTv();
}
