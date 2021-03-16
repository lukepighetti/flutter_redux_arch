import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:redux_sandbox/screens/todo_screen.dart';
import 'package:redux_sandbox/state/reducer.dart';

import 'state/models.dart';

void main() async {
  final remoteDevTools = RemoteDevToolsMiddleware('localhost:8000');
  await remoteDevTools.connect();

  final store = DevToolsStore<AppState>(
    todosReducer,
    initialState: AppState(
      now: DateTime.now(),
    ),
    middleware: [remoteDevTools],
  );

  remoteDevTools.store = store;

  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, @required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Redux',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoScreen(),
      ),
    );
  }
}
