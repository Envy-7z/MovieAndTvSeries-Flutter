import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_detail_state.dart';

import '../../../domain/usecases/tv/get_tv_detail.dart';
import '../../../domain/usecases/tv/get_tv_recommendations.dart';
import '../../../domain/usecases/tv/get_watchlist_status_tv.dart';
import '../../../domain/usecases/tv/remove_watchlist_tv.dart';
import '../../../domain/usecases/tv/save_watchlist_tv.dart';

class DetailBlocTv extends Bloc<DetailEventTv, DetailStateTv> {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatusTv getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  static const watchListAdd = 'Added to Watchlist';
  static const watchListRemove = 'Removed from Watchlist';

  DetailBlocTv(this.getTvDetail, this.getTvRecommendations,
      this.getWatchListStatus, this.saveWatchlist, this.removeWatchlist)
      : super(DetailStateTv.initial()) {
    on<OnDetailList>(
      (event, emit) async {
        emit(state.copyWith(
          tvDetailState: RequestState.Loading,
        ));
        final result = await getTvDetail.execute(event.id);
        final recomendation = await getTvRecommendations.execute(event.id);

        result.fold(
          (failure) {
            emit(state.copyWith(
              tvDetailState: RequestState.Error,
              message: failure.message,
            ));
          },
          (detail) {
            emit(state.copyWith(
              tvRecommendationState: RequestState.Loading,
              message: '',
              tvDetailState: RequestState.Loaded,
              tvDetail: detail,
            ));
            recomendation.fold((failure) {
              emit(state.copyWith(
                tvRecommendationState: RequestState.Error,
                message: failure.message,
              ));
            }, (recomended) {
              emit(state.copyWith(
                tvRecommendations: recomended,
                tvRecommendationState: RequestState.Loaded,
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
