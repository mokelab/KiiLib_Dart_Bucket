import './KiiClause.dart';

class QueryParams {
  final KiiClause clause;
  final String orderBy;
  final bool descending;
  final int limit;
  String paginationKey;

  QueryParams(this.clause, this.orderBy, this.descending, this.limit,
      this.paginationKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    Map<String, dynamic> query = Map<String, dynamic>();
    query["clause"] = this.clause.toJson();
    if (this.orderBy.length > 0) {
      query["orderBy"] = this.orderBy;
      query["descending"] = this.descending;
    }

    json["bucketQuery"] = query;
    if (this.limit > 0) {
      json["bestEffortLimit"] = this.limit;
    }
    if (this.paginationKey.length > 0) {
      json["paginationKey"] = this.paginationKey;
    }

    return json;
  }
}

class QueryParamsBuilder {
  final KiiClause clause;
  String _orderBy = "";
  bool _descending = false;
  int _limit = 0;
  String _paginationKey = "";

  QueryParamsBuilder(this.clause);

  QueryParamsBuilder orderBy(String field, bool descending) {
    this._orderBy = field;
    this._descending = descending;
    return this;
  }

  QueryParamsBuilder limit(int limit) {
    this._limit = limit;
    return this;
  }

  QueryParamsBuilder paginationKey(String key) {
    this._paginationKey = key;
    return this;
  }

  QueryParams build() {
    return QueryParams(this.clause, this._orderBy, this._descending,
        this._limit, this._paginationKey);
  }
}
