import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:redux_sandbox/remote_dev_tools.dart';
import 'package:redux_sandbox/screens/todo_screen.dart';
import 'package:redux_sandbox/service/toast_service.dart';
import 'package:redux_sandbox/state/actions.dart';
import 'package:redux_sandbox/state/reducer.dart';
import 'package:redux_sandbox/state/shared_preferences_storage.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'extensions.dart';
import 'state/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Create remote dev tools client
  final remoteDevTools = RemoteDevToolsMiddleware(
    '192.168.1.121:8000',
    actionEncoder: actionEncoder,
    actionDecoder: actionDecoder,
  );

  await remoteDevTools.connect().ignoreErrors();

  /// Create persistance service
  final persistor = Persistor<AppState>(
    storage: SharedPreferencesStorage(),
    serializer: JsonSerializer<AppState>((json) => AppState.fromJson(json)),
  );

  /// Setup initial state, get persisted state
  final initialState = AppState(
    now: DateTime.now(),
  );

  final persistedState = await persistor.load().ignoreErrors();

  /// Setup store
  final store = DevToolsStore<AppState>(
    todosReducer,
    middleware: [
      remoteDevTools,
      persistor.createMiddleware(),
      LoggingMiddleware.printer(),
      thunkMiddleware,
    ],
  );

  /// Register store with remote dev tools
  remoteDevTools.store = store;

  /// Hydrate the store
  store.dispatch(StoreAction.hydrate(
    persistedState ?? initialState,
  ));

  /// Setup [ToastService] messenger key
  ToastService.messenger = GlobalKey<ScaffoldMessengerState>();

  /// Run the app
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
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: ToastService.messenger,
        home: TodoScreen(),
      ),
    );
  }
}
