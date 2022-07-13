import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_watchlist_event.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_watchlist_state.dart';

import '../../../domain/usecases/tv/get_watchlist_tv.dart';

class WatchlistBlocTv extends Bloc<WatchlistEventTv, WatchlistStateTv> {
  final GetWatchlistTv getWatchlist;

  WatchlistBlocTv(this.getWatchlist) : super(WatchlistEmpty()) {
    on<WatchlistTv>(
      (event, emit) async {
        emit(WatchlistLoading());
        final result = await getWatchlist.execute();

        result.fold(
          (failure) {
            emit(WatchlistError(
              failure.message,
            ));
          },
          (data) {
            emit(WatchlistHasData(data));
          },
        );
      },
    );
  }
}
