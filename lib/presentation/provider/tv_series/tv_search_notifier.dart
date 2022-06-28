import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv/search_tv.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/tv.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTv searchTvShows;

  TvSearchNotifier({required this.searchTvShows});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvShow> _searchResult = [];

  List<TvShow> get searchResult => _searchResult;

  String _message = '';

  String get message => _message;

  Future<void> fetchTvShowSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvShows.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
