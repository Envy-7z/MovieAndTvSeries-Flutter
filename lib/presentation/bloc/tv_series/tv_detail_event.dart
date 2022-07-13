import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

abstract class DetailEventTv extends Equatable {
  const DetailEventTv();

  @override
  List<Object> get props => [];
}

class OnDetailList extends DetailEventTv {
  final int id;

  const OnDetailList(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends DetailEventTv {
  final TvDetail movieDetail;

  const AddWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class EraseWatchlist extends DetailEventTv {
  final TvDetail movieDetail;

  const EraseWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class WatchlistStatus extends DetailEventTv {
  final int id;

  const WatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
