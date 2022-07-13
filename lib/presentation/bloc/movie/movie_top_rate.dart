import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/movie/get_top_rated_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class TopRatedMovie extends Bloc<EventMovie, StateMovie> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovie(this._getTopRatedMovies) : super(MovieEmpty()) {
    on<OnListMovie>(
      (event, emit) async {
        emit(MovieLoading());
        final result = await _getTopRatedMovies.execute();

        result.fold(
          (failure) {
            emit(MovieError(failure.message));
          },
          (data) {
            emit(MovieHasData(data));
          },
        );
      },
    );
  }
}
