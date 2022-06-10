import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlProviderClass {

  //static HttpLink httpLink = HttpLink("https://graphqlzero.almansi.me/api",);

  static HttpLink httpLink = HttpLink("https://ea8a-110-227-244-177.ngrok.io/graphql",);

  static Link linked = httpLink;

  ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(
      link: linked,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      link: linked,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );
  }
}
