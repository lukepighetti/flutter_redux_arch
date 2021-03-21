import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:redux_sandbox/service/toast_service.dart';
import 'package:redux_sandbox/service/todo_api.dart';
import 'package:redux_sandbox/state/actions.dart';
import 'package:redux_sandbox/state/models.dart';
import 'package:redux_thunk/redux_thunk.dart';

class TodoThunkServices {
  /// The services we need to dispatch these thunks
  TodoThunkServices({
    @required this.toastService,
    @required this.todoApi,
  });

  final ToastService toastService;

  final TodoApi todoApi;
}

/// Fetch some adventurous todos
///
/// Logs as `Closure: (Store<AppState>) => void from Function 'fetchAdventurousTodos': static`
ThunkAction<AppState> fetchAdventurousTodos(TodoThunkServices services) {
  return _fetchTodos(services, TodoType.adventurous);
}

/// Fetch some risky todos
///
/// Logs as `Closure: (Store<AppState>) => void from Function 'fetchRiskyTodos': static`
ThunkAction<AppState> fetchRiskyTodos(TodoThunkServices services) {
  return _fetchTodos(services, TodoType.risky);
}

/// The base action for fetching todos, handling errors, and allowing a retry
ThunkAction<AppState> _fetchTodos(TodoThunkServices services, TodoType type) {
  return (Store<AppState> store) async {
    store.dispatch(TodoAction.fetching(true));

    try {
      final todos = await services.todoApi.getTodos(type);
      store.dispatch(TodoAction.add(todos));
    } on TodoApiError catch (e) {
      services.toastService.showErrorToast(
        '${e.message}',
        onPressRetry: () => store.dispatch(_fetchTodos(services, type)),
      );
    } finally {
      store.dispatch(TodoAction.fetching(false));
    }
  };
}
