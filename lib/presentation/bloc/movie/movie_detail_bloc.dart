import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/movie/get_movie_detail.dart';
import '../../../domain/usecases/movie/get_movie_recommendations.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class DetailBlocMovie extends Bloc<DetailEventMovie, DetailStateMovie> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  static const watchListAdd = 'Added to Watchlist';
  static const watchListRemove = 'Removed from Watchlist';

  DetailBlocMovie(this.getMovieDetail, this.getMovieRecommendations,
      this.getWatchListStatus, this.saveWatchlist, this.removeWatchlist)
      : super(DetailStateMovie.initial()) {
    on<OnDetailList>(
      (event, emit) async {
        emit(state.copyWith(
          movieDetailState: RequestState.Loading,
        ));
        final result = await getMovieDetail.execute(event.id);
        final recommendation = await getMovieRecommendations.execute(event.id);

        result.fold(
          (failure) {
            emit(state.copyWith(
              movieDetailState: RequestState.Error,
              message: failure.message,
            ));
          },
          (detail) {
            emit(state.copyWith(
              movieRecommendationState: RequestState.Loading,
              message: '',
              movieDetailState: RequestState.Loaded,
              movieDetail: detail,
            ));
            recommendation.fold((failure) {
              emit(state.copyWith(
                movieRecommendationState: RequestState.Error,
                message: failure.message,
              ));
            }, (recommended) {
              emit(state.copyWith(
                movieRecommendations: recommended,
                movieRecommendationState: RequestState.Loaded,
                message: '',
              ));
            });
          },
        );
      },
    );
    on<AddWatchlist>(
      (event, emit) async {
        final result = await saveWatchlist.execute(event.movieDetail);

        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (added) {
            emit(state.copyWith(
              watchlistMessage: watchListAdd,
            ));
          },
        );

        add(WatchlistStatus(event.movieDetail.id));
      },
    );
    on<EraseWatchlist>(
      (event, emit) async {
        final result = await removeWatchlist.execute(event.movieDetail);
        result.fold(
          (failure) {
            emit(state.copyWith(watchlistMessage: failure.message));
          },
          (added) {
            emit(state.copyWith(
              watchlistMessage: watchListRemove,
            ));
          },
        );
        add(WatchlistStatus(event.movieDetail.id));
      },
    );
    on<WatchlistStatus>(
      (event, emit) async {
        final result = await getWatchListStatus.execute(event.id);
        emit(state.copyWith(isAddedToWatchlist: result));
      },
    );
  }
}
