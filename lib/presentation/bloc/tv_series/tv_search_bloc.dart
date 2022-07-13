import 'package:ditonton/presentation/bloc/tv_series/tv_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/tv/search_tv.dart';
import '../search_event.dart';

class SearchBlocTv extends Bloc<SearchEvent, SearchStateTv> {
  final SearchTv searchTv;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchBlocTv(this.searchTv) : super(SearchTvEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchTvLoading());
        final result = await searchTv.execute(query);

        result.fold(
          (failure) {
            emit(SearchTvError(failure.message));
          },
          (data) {
            emit(SearchTvHasData(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}
