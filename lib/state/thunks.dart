import 'package:redux/redux.dart';
import 'package:redux_sandbox/state/actions.dart';
import 'package:redux_sandbox/state/models.dart';
import 'package:redux_thunk/redux_thunk.dart';

/// Fetch some adventurous todos
///
/// Logs as `Closure: (Store<AppState>) => void from Function 'fetchAdventurousTodos': static`
ThunkAction<AppState> fetchAdventurousTodos = (Store<AppState> store) async {
  store.dispatch(SetFetchingTodosAction(true));

  await Future.delayed(Duration(seconds: 1));

  final todos = [
    Todo('Build a canoe'),
    Todo('Paddle the Allagash'),
    Todo('Build a log cabin'),
  ];

  store.dispatch(AddTodosAction(todos));
  store.dispatch(SetFetchingTodosAction(false));
};

/// Fetch some risky todos
///
/// Logs as `Closure: (Store<AppState>) => void from Function 'fetchRiskyTodos': static`
ThunkAction<AppState> fetchRiskyTodos = (Store<AppState> store) async {
  store.dispatch(SetFetchingTodosAction(true));

  await Future.delayed(Duration(seconds: 1));

  final todos = [
    Todo('Make popcorn'),
    Todo('Netflix & chill'),
  ];

  store.dispatch(AddTodosAction(todos));
  store.dispatch(SetFetchingTodosAction(false));
};
