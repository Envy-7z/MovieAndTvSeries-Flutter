import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class SearchStateMovie extends Equatable {
  const SearchStateMovie();

  @override
  List<Object> get props => [];
}

class SearchMovieEmpty extends SearchStateMovie {}

class SearchMovieLoading extends SearchStateMovie {}

class SearchMovieError extends SearchStateMovie {
  final String data;

  const SearchMovieError(this.data);

  @override
  List<Object> get props => [data];
}

class SearchMovieHasData extends SearchStateMovie {
  final List<Movie> result;

  const SearchMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
