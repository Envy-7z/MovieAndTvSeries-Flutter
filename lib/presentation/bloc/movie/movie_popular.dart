import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/movie/get_popular_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class PopularMovie extends Bloc<EventMovie, StateMovie> {
  final GetPopularMovies _getPopularMovies;

  PopularMovie(this._getPopularMovies) : super(MovieEmpty()) {
    on<OnListMovie>(
      (event, emit) async {
        emit(MovieLoading());
        final result = await _getPopularMovies.execute();

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
