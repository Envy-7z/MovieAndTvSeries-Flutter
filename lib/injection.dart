import 'package:ditonton/common/ssl_pin.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_list.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_popular.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_top_rate.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_watchlist_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/db/database_helper_tv.dart';
import 'data/datasources/tv_local_data_source.dart';
import 'data/datasources/tv_remote_data_source.dart';
import 'data/repositories/tv_repository_impl.dart';
import 'domain/repositories/tv_repository.dart';
import 'domain/usecases/tv/get_now_playing_tv.dart';
import 'domain/usecases/tv/get_popular_tv.dart';
import 'domain/usecases/tv/get_top_rated_tv.dart';
import 'domain/usecases/tv/get_tv_detail.dart';
import 'domain/usecases/tv/get_tv_recommendations.dart';
import 'domain/usecases/tv/get_watchlist_status_tv.dart';
import 'domain/usecases/tv/get_watchlist_tv.dart';
import 'domain/usecases/tv/remove_watchlist_tv.dart';
import 'domain/usecases/tv/save_watchlist_tv.dart';
import 'domain/usecases/tv/search_tv.dart';
import 'presentation/bloc/movie/movie_top_rate.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(
    () => ListMovie(
      locator(),
    ),
  );
  locator.registerFactory(
    () => ListTv(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMovie(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTv(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMovie(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTv(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailBlocMovie(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailBlocTv(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistBlocMovie(
      locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistBlocTv(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchBlocMovie(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchBlocTv(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  //use case tvseries
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTv>(() => DatabaseHelperTv());

  // external

  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
