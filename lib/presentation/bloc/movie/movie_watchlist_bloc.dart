import 'package:bloc/bloc.dart';

import '../../../domain/usecases/movie/get_watchlist_movies.dart';
import 'movie_watchlist_event.dart';
import 'movie_watchlist_state.dart';

class WatchlistBlocMovie
    extends Bloc<WatchlistEventMovie, WatchlistStateMovie> {
  final GetWatchlistMovies getWatchlist;

  WatchlistBlocMovie(this.getWatchlist) : super(WatchlistEmpty()) {
    on<WatchlistMovie>(
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
