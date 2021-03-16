import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_sandbox/state/reducer.dart';

import 'state/models.dart';

void main() {
  final store = Store<AppState>(
    todosReducer,
    initialState: AppState(),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redux',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
