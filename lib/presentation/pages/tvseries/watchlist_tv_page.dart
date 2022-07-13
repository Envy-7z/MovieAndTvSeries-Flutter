import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../common/utils.dart';
import '../../bloc/tv_series/tv_watchlist_bloc.dart';
import '../../bloc/tv_series/tv_watchlist_event.dart';
import '../../bloc/tv_series/tv_watchlist_state.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist_Tv';

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistBlocTv>().add(WatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistBlocTv>().add(WatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistBlocTv, WatchlistStateTv>(
          builder: (context, state) {
            if (state is WatchlistLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv);
                },
                itemCount: result.length,
              );
            } else {
              return Center(
                child: Text("Failed load watchlist Tv series"),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
