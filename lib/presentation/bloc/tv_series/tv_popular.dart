import 'package:ditonton/presentation/bloc/tv_series/tv_event.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/tv/get_popular_tv.dart';

class PopularTv extends Bloc<EventTv, StateTv> {
  final GetPopularTv _getPopularTv;

  PopularTv(this._getPopularTv) : super(TvEmpty()) {
    on<OnListTv>(
      (event, emit) async {
        emit(TvLoading());
        final result = await _getPopularTv.execute();

        result.fold(
          (failure) {
            emit(TvError(failure.message));
          },
          (data) {
            emit(TvHasData(data));
          },
        );
      },
    );
  }
}
