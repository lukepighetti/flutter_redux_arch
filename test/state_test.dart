import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:redux_sandbox/state/actions.dart';
import 'package:redux_sandbox/state/models.dart';
import 'package:redux_sandbox/state/reducer.dart';
import 'package:redux_sandbox/state/selectors.dart';

main() {
  final now = DateTime(2000);

  Store<AppState> createStore() {
    return Store<AppState>(
      todosReducer,
      initialState: AppState(now: now),
    );
  }

  group('AppState', () {
    test('initial state', () {
      final store = createStore();

      expect(store.state.todos, isEmpty);
      expect(store.state.visibilityFilter, equals(VisibilityFilter.showAll));
    });

    test('Create/Update/Delete/Toggle TodoAction', () {
      final store = createStore();

      /// Add a todo
      store.dispatch(CreateTodoAction(
        Todo('Build app'),
      ));

      expect(store.state.todos, isNotEmpty);
      expect(store.state.todos.first.task, equals('Build app'));
      expect(store.state.todos.first.completed, isFalse);

      /// Toggle a todo
      store.dispatch(ToggleTodoAction(
        Todo('Build app'),
      ));

      expect(store.state.todos, isNotEmpty);
      expect(store.state.todos.first.completed, isTrue);

      /// Update a todo
      store.dispatch(UpdateTodoAction(
        Todo('Build app'),
        Todo('Test app'),
      ));

      expect(store.state.todos, isNotEmpty);
      expect(store.state.todos.first.task, equals('Test app'));

      /// Delete a todo
      store.dispatch(DeleteTodoAction(
        Todo('Test app'),
      ));

      expect(store.state.todos, isEmpty);
    });

    test('SetVisibilityFilter', () {
      final store = createStore();

      /// Change visibility filter
      store.dispatch(SetVisibilityFilter(
        VisibilityFilter.showComplete,
      ));

      expect(
          store.state.visibilityFilter, equals(VisibilityFilter.showComplete));
    });

    test(
        'completeTodosSelector, incompleteTodosSelector, scheduledTodosSelector',
        () {
      final store = createStore();

      store.dispatch(CreateTodoAction(
        Todo(
          'Foo',
          completed: true,
          due: now.add(Duration(days: 1)),
        ),
      ));

      store.dispatch(CreateTodoAction(
        Todo(
          'Bar',
          completed: false,
          due: now.subtract(Duration(days: 1)),
        ),
      ));

      final completeTodos = completeTodosSelector(store.state);
      expect(completeTodos.length, equals(1));
      expect(completeTodos.first.task, equals('Foo'));

      final incompleteTodos = incompleteTodosSelector(store.state);
      expect(incompleteTodos.length, equals(1));
      expect(incompleteTodos.first.task, equals('Bar'));

      final scheduledTodos = scheduledTodosSelector(store.state);
      expect(scheduledTodos.length, equals(2));

      final upcomingTodos = upcomingTodosSelector(store.state);
      expect(upcomingTodos.length, equals(1));
      expect(upcomingTodos.first.task, equals('Foo'));

      final pastTodos = pastTodosSelector(store.state);
      expect(pastTodos.length, equals(1));
      expect(pastTodos.first.task, equals('Bar'));

      final completeTodosCount = completeTodosCountSelector(store.state);
      expect(completeTodosCount, equals(1));

      final incompleteTodosCount = incompleteTodosCountSelector(store.state);
      expect(incompleteTodosCount, equals(1));

      final totalTodosCount = totalTodosCountSelector(store.state);
      expect(totalTodosCount, equals(2));
    });
  });
}
