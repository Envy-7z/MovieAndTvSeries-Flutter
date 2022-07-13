import 'package:ditonton/presentation/bloc/tv_series/tv_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../bloc/tv_series/tv_event.dart';
import '../../bloc/tv_series/tv_state.dart';

class NowPlayingTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv-page';

  @override
  _NowPlayingPageState createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<ListTv>().add(OnListTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ListTv, StateTv>(
          builder: (context, state) {
            if (state is TvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvHasData) {
              final data = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data[index];
                  return TvCard(tvShow);
                },
                itemCount: data.length,
              );
            } else {
              return Center(
                child: Text('Failed to load now playing Tv'),
              );
            }
          },
        ),
      ),
    );
  }
}
