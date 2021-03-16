import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:redux_sandbox/state/actions.dart';
import 'package:redux_sandbox/state/models.dart';
import 'package:redux_sandbox/state/reducer.dart';
import 'package:redux_sandbox/state/selectors.dart';

main() {
  Store<AppState> createStore() {
    return Store<AppState>(
      todosReducer,
      initialState: AppState(),
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
        (e) => e.copyWith(task: 'Test app'),
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
      final now = DateTime(2000);

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
        ),
      ));

      final completeTodos = completeTodosSelector(store.state);
      expect(completeTodos.length, equals(1));
      expect(completeTodos.first.task, equals('Foo'));

      final incompleteTodos = incompleteTodosSelector(store.state);
      expect(incompleteTodos.length, equals(1));
      expect(incompleteTodos.first.task, equals('Bar'));

      final scheduledTodos = scheduledTodosSelector(store.state);
      expect(scheduledTodos.length, equals(1));
      expect(scheduledTodos.first.task, equals('Foo'));
    });
  });
}
