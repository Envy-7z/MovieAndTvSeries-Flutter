import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv/search_tv.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search_state.dart';
import 'package:ditonton/presentation/bloc/search_event.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../provider/movie_search_notifier_test.mocks.dart';
import '../provider/tvseries/tv_search_notifier_test.mocks.dart';


@GenerateMocks([SearchMovies, SearchTv])
void main() {
  late SearchBlocMovie searchMovieBloc;
  late SearchBlocTv searchTvShowBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTv mockSearchTvShows;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTvShows = MockSearchTv();
    searchMovieBloc = SearchBlocMovie(mockSearchMovies);
    searchTvShowBloc = SearchBlocTv(mockSearchTvShows);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';

  group('Search Movies', () {
    test('Initial state should be empty', () {
      expect(searchMovieBloc.state, SearchMovieEmpty());
    });

    blocTest<SearchBlocMovie, SearchStateMovie>(
      'Should emit [SearchLoading, SearchHasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMovieLoading(),
        SearchMovieHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchBlocMovie, SearchStateMovie>(
      'Should emit [SearchLoading, SearchHasData[], SearchEmpty] when data is empty',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(<Movie>[]));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMovieLoading(),
        SearchMovieHasData(<Movie>[]),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchBlocMovie, SearchStateMovie>(
      'Should emit [SearchLoading, SearchError] when data is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMovieLoading(),
        SearchMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });

  final tTvShowModel = TvShow(
      backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
      genreIds: [10759, 10765],
      id: 52814,
      name: "Halo",
      originalName: "Halo",
      overview:
          "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
      popularity: 7348.55,
      posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
      voteAverage: 8.7,
      voteCount: 472);
  final tTvShowList = <TvShow>[tTvShowModel];
  final tQueryTvShow = 'Halo';

  group('Search Tv Shows', () {
    test('Initial state should be empty', () {
      expect(searchTvShowBloc.state, SearchTvEmpty());
    });

    blocTest<SearchBlocTv, SearchStateTv>(
      'Should emit [SearchLoading, SearchHasData] when data is gotten successfully',
      build: () {
        when(mockSearchTvShows.execute(tQueryTvShow))
            .thenAnswer((_) async => Right(tTvShowList));
        return searchTvShowBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvLoading(),
        SearchTvHasData(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQueryTvShow));
      },
    );

    blocTest<SearchBlocTv, SearchStateTv>(
      'Should emit [SearchLoading, SearchHasData[], SearchEmpty] when data is empty',
      build: () {
        when(mockSearchTvShows.execute(tQueryTvShow))
            .thenAnswer((_) async => Right(<TvShow>[]));
        return searchTvShowBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvLoading(),
        SearchTvHasData(<TvShow>[]),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQueryTvShow));
      },
    );

    blocTest<SearchBlocTv, SearchStateTv>(
      'Should emit [SearchLoading, SearchError] when data is unsuccessful',
      build: () {
        when(mockSearchTvShows.execute(tQueryTvShow))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchTvShowBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvLoading(),
        SearchTvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQueryTvShow));
      },
    );
  });
}
