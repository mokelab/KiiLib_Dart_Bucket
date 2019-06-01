import 'package:kiilib_core/kiilib_core.dart';
import './QueryParams.dart';

class QueryResult {
  final List<KiiObject> results;
  final QueryParams params;

  QueryResult(this.results, this.params);
}

abstract class BucketAPI {
  Future<QueryResult> query(KiiBucket bucket, QueryParams params);
}
