import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular.dart';
import 'package:ditonton/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_top_rate.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_list.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_popular.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_top_rate.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/movies/about_page.dart';
import 'package:ditonton/presentation/pages/movies/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movies/search_page.dart';
import 'package:ditonton/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tvseries/home_tv_page.dart';
import 'package:ditonton/presentation/pages/tvseries/now_playing_tv_page.dart';
import 'package:ditonton/presentation/pages/tvseries/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tvseries/search_tv_page.dart';
import 'package:ditonton/presentation/pages/tvseries/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tvseries/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tvseries/watchlist_tv_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'common/ssl_pin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  await Firebase.initializeApp();

  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<ListMovie>()),
        BlocProvider(create: (_) => di.locator<PopularMovie>()),
        BlocProvider(create: (_) => di.locator<TopRatedMovie>()),
        BlocProvider(create: (_) => di.locator<DetailBlocMovie>()),
        BlocProvider(create: (_) => di.locator<WatchlistBlocMovie>()),
        BlocProvider(create: (_) => di.locator<SearchBlocMovie>()),
        BlocProvider(create: (_) => di.locator<ListTv>()),
        BlocProvider(create: (_) => di.locator<DetailBlocTv>()),
        BlocProvider(create: (_) => di.locator<PopularTv>()),
        BlocProvider(create: (_) => di.locator<TopRatedTv>()),
        BlocProvider(create: (_) => di.locator<SearchBlocTv>()),
        BlocProvider(create: (_) => di.locator<WatchlistBlocTv>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeTvPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case HomeTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case PopularTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularTvPage());
            case TopRatedTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedTvPage());
            case WatchlistTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            case SearchTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SearchTvPage());
            case NowPlayingTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => NowPlayingTvPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
