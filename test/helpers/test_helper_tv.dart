import 'package:ditonton/data/datasources/db/database_helper_tv.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelperTv,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
