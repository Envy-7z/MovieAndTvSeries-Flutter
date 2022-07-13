import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/movie/search_movies.dart';
import '../search_event.dart';
import 'movie_search_state.dart';

class SearchBlocMovie extends Bloc<SearchEvent, SearchStateMovie> {
  final SearchMovies searchMovies;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchBlocMovie(this.searchMovies) : super(SearchMovieEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchMovieLoading());
        final result = await searchMovies.execute(query);

        result.fold(
          (failure) {
            emit(SearchMovieError(failure.message));
          },
          (data) {
            emit(SearchMovieHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
