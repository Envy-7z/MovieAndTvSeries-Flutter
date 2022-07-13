import 'package:ditonton/presentation/bloc/tv_series/tv_event.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/tv/get_now_playing_tv.dart';

class ListTv extends Bloc<EventTv, StateTv> {
  final GetNowPlayingTv _getNowPlayingTv;

  ListTv(this._getNowPlayingTv) : super(TvEmpty()) {
    on<OnListTv>(
      (event, emit) async {
        emit(TvLoading());
        final result = await _getNowPlayingTv.execute();

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
