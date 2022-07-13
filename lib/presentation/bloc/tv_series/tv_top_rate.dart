import 'package:ditonton/presentation/bloc/tv_series/tv_event.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/tv/get_top_rated_tv.dart';

class TopRatedTv extends Bloc<EventTv, StateTv> {
  final GetTopRatedTv _getTopRatedTv;

  TopRatedTv(this._getTopRatedTv) : super(TvEmpty()) {
    on<OnListTv>(
      (event, emit) async {
        emit(TvLoading());
        final result = await _getTopRatedTv.execute();

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
