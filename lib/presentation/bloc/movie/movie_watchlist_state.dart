import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class WatchlistStateMovie extends Equatable {
  const WatchlistStateMovie();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistStateMovie {}

class WatchlistLoading extends WatchlistStateMovie {}

class WatchlistError extends WatchlistStateMovie {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData extends WatchlistStateMovie {
  final List<Movie> result;

  const WatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}
