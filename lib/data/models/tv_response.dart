import 'package:ditonton/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';

class TvResponse extends Equatable {
  final List<TvSeriesModel> TvList;

  TvResponse({required this.TvList});

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        TvList: List<TvSeriesModel>.from((json["results"] as List)
            .map((x) => TvSeriesModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(TvList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [TvList];
}
