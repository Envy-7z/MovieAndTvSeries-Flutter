import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class DetailStateTv extends Equatable {
  final TvDetail? tvDetail;
  final List<TvShow> tvRecommendations;
  final RequestState tvDetailState;
  final RequestState tvRecommendationState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  DetailStateTv({
    required this.tvDetail,
    required this.tvRecommendations,
    required this.tvDetailState,
    required this.tvRecommendationState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  DetailStateTv copyWith({
    TvDetail? tvDetail,
    List<TvShow>? tvRecommendations,
    RequestState? tvDetailState,
    RequestState? tvRecommendationState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return DetailStateTv(
      tvDetail: tvDetail ?? this.tvDetail,
      tvRecommendations: tvRecommendations ?? this.tvRecommendations,
      tvDetailState: tvDetailState ?? this.tvDetailState,
      tvRecommendationState:
          tvRecommendationState ?? this.tvRecommendationState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory DetailStateTv.initial() {
    return DetailStateTv(
      tvDetail: null,
      tvRecommendations: [],
      tvDetailState: RequestState.Empty,
      tvRecommendationState: RequestState.Empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }

  @override
  List<Object?> get props => [
        tvDetail,
        tvRecommendations,
        tvDetailState,
        tvRecommendationState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}
