import 'package:redux/redux.dart';
import 'package:redux_sandbox/service/todo_api.dart';
import 'package:redux_sandbox/state/models.dart';
import 'package:redux_sandbox/state/reducer.dart';
import 'package:redux_sandbox/state/thunks.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'mock_toast_service.dart';

class TestUtils {
  /// A stub date for testing
  static final now = DateTime(2000);

  /// Create a store for testing purposes
  static Store<AppState> createStore() {
    return Store<AppState>(
      todosReducer,
      initialState: AppState(now: now),
      middleware: [
        thunkMiddleware,
      ],
    );
  }

  /// Create todo thunk services for testing purposes
  static TodoThunkServices createTodoThunkServices(
      StubErrorFrequency errorFrequency) {
    return TodoThunkServices(
      toastService: MockToastService(),
      todoApi: TodoApi(
        throwRandomNetworkErrors: errorFrequency,
      ),
    );
  }
}
