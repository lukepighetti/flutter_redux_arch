import 'package:redux_sandbox/state/models.dart';

final completeTodosSelector =
    (AppState state) => state.todos.where((e) => e.completed);

final incompleteTodosSelector =
    (AppState state) => state.todos.where((e) => !e.completed);

final scheduledTodosSelector =
    (AppState state) => state.todos.where((e) => e.due != null);
