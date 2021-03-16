import 'package:redux_sandbox/state/models.dart';
import 'package:reselect/reselect.dart';

/// Select all todos
final todosSelector = (AppState state) => state.todos;

/// Select all completed todos
final completeTodosSelector =
    (AppState state) => state.todos.where((e) => e.completed);

/// Select all incomplete todos
final incompleteTodosSelector =
    (AppState state) => state.todos.where((e) => !e.completed);

/// Select all todos with a due date
final scheduledTodosSelector =
    (AppState state) => state.todos.where((e) => e.due != null);

/// Select all todos with a due date in the future
final upcomingTodosSelector =
    (AppState state) => state.todos.where((e) => e.due.isAfter(state.now));

/// Select all todos with a due date in the past
final pastTodosSelector =
    (AppState state) => state.todos.where((e) => e.due.isBefore(state.now));

/// Select number of past todos
final completeTodosCountSelector =
    createIterableLengthSelector<Todo>(completeTodosSelector);

/// Select number of past todos
final incompleteTodosCountSelector =
    createIterableLengthSelector<Todo>(incompleteTodosSelector);

/// The total number of todos
final totalTodosCountSelector = createSelector2<AppState, int, int, int>(
    completeTodosCountSelector, incompleteTodosCountSelector, (a, b) => a + b);

/// Given a selector that produces an `Iterable<T>`, return the length.
///
/// This pattern is very verbose and probably isn't worth it. But it is doable.
AppSelector<int> createIterableLengthSelector<T>(
    AppSelector<Iterable<T>> selector) {
  return createSelector1<AppState, Iterable<T>, int>(selector, (e) => e.length);
}

/// A selector typedef for this particular app. Acts on [AppState]
typedef AppSelector<R1> = R1 Function(AppState);
