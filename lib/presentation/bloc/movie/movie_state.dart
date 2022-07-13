import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class StateMovie extends Equatable {
  const StateMovie();

  @override
  List<Object> get props => [];
}

class MovieEmpty extends StateMovie {}

class MovieLoading extends StateMovie {}

class MovieError extends StateMovie {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieHasData extends StateMovie {
  final List<Movie> result;

  const MovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
