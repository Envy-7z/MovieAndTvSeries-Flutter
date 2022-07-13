import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class DetailEventMovie extends Equatable {
  const DetailEventMovie();

  @override
  List<Object> get props => [];
}

class OnDetailList extends DetailEventMovie {
  final int id;

  const OnDetailList(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends DetailEventMovie {
  final MovieDetail movieDetail;

  const AddWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class EraseWatchlist extends DetailEventMovie {
  final MovieDetail movieDetail;

  const EraseWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class WatchlistStatus extends DetailEventMovie {
  final int id;

  const WatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
