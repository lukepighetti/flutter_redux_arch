import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'models.dart';

class AppStateConnector extends StatelessWidget {
  /// A naiive redux store connector specifically made for this app
  const AppStateConnector({Key key, this.builder}) : super(key: key);

  final Widget Function(BuildContext, AppState state, NextDispatcher dispatch)
      builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (e) => e,
      builder: (context, store) {
        return builder(context, store.state, store.dispatch);
      },
    );
  }
}
