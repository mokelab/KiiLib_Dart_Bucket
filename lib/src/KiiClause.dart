class KiiClause {
  final Map<String, dynamic> clause = Map<String, dynamic>();

  KiiClause(String type) {
    this.clause["type"] = type;
  }

  static KiiClause all() {
    return KiiClause('all');
  }

  static KiiClause equals(String field, dynamic value) {
    var c = KiiClause('eq');
    c.clause['field'] = field;
    c.clause['value'] = value;
    return c;
  }

  static KiiClause greaterThan(String field, dynamic value, bool include) {
    var c = KiiClause('range');
    c.clause['field'] = field;
    c.clause['lowerLimit'] = value;
    c.clause['lowerIncluded'] = include;
    return c;
  }

  static KiiClause lessThan(String field, dynamic value, bool include) {
    var c = new KiiClause('range');
    c.clause['field'] = field;
    c.clause['upperLimit'] = value;
    c.clause['upperIncluded'] = include;
    return c;
  }

  static KiiClause range(String field, dynamic fromValue, bool fromInclude,
      dynamic toValue, bool toInclude) {
    var c = KiiClause('range');
    c.clause['field'] = field;
    c.clause['lowerLimit'] = fromValue;
    c.clause['lowerIncluded'] = fromInclude;
    c.clause['upperLimit'] = toValue;
    c.clause['upperIncluded'] = toInclude;

    return c;
  }

  static KiiClause inClause<T>(String field, List<T> values) {
    var c = new KiiClause('in');
    c.clause['field'] = field;
    c.clause['values'] = values;
    return c;
  }

  static KiiClause not(KiiClause clause) {
    var c = new KiiClause('not');
    c.clause['clause'] = clause.toJson();
    return c;
  }

  static KiiClause andClause(List<KiiClause> array) {
    var c = new KiiClause('and');
    c.clause['clauses'] = KiiClause._toClauses(array);

    return c;
  }

  static KiiClause orClause(List<KiiClause> array) {
    var c = new KiiClause('or');
    c.clause['clauses'] = KiiClause._toClauses(array);

    return c;
  }

  static List<Map<String, dynamic>> _toClauses(List<KiiClause> array) {
    return array.map((KiiClause c) => c.toJson());
  }

  Map<String, dynamic> toJson() {
    return this.clause;
  }
}
