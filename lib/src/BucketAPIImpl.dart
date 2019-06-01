import 'package:kiilib_core/kiilib_core.dart';
import 'package:kiilib_core/src/KiiBucket.dart';
import 'dart:convert';

import './BucketAPI.dart';
import './QueryParams.dart';

class BucketAPIImpl implements BucketAPI {
  final KiiContext context;

  BucketAPIImpl(this.context);

  @override
  Future<QueryResult> query(KiiBucket bucket, QueryParams params) async {
    var url =
        "${this.context.baseURL}/apps/${this.context.appID}${bucket.path}/query";
    var headers = this.context.makeAuthHeader();
    headers["Content-Type"] = "application/vnd.kii.QueryRequest+json";

    var response = await this
        .context
        .client
        .sendJson(Method.POST, url, headers, params.toJson());
    if (response.status != 200) {
      print(response.body);
      throw Exception("Error");
    }

    var bodyJson = jsonDecode(response.body) as Map<String, dynamic>;
    String nextPaginationKey = bodyJson["nextPaginationKey"];
    params.paginationKey = nextPaginationKey;

    var results = bodyJson["results"] as List<dynamic>;
    var objList = results.map((dynamic item) {
      var json = item as Map<String, dynamic>;
      var objectID = json["_id"];
      var obj = KiiObject.withId(bucket, objectID);
      obj.replace(json);
      return obj;
    }).toList();
    return QueryResult(objList, params);
  }
}
