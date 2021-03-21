import 'package:flutter_test/flutter_test.dart';
import 'package:redux_sandbox/state/actions.dart';
import 'package:redux_sandbox/state/models.dart';

import 'utils.dart';

main() {
  group('Actions', () {
    test('FetchingTodosAction', () {
      final store = TestUtils.createStore();

      /// Initial state
      expect(store.state.fetchingTodos, isFalse);

      /// Is fetching
      store.dispatch(SetFetchingTodosAction(true));
      expect(store.state.fetchingTodos, isTrue);

      /// Done fetching
      store.dispatch(SetFetchingTodosAction(false));
      expect(store.state.fetchingTodos, isFalse);
    });

    test('AddTodosAction', () {
      final store = TestUtils.createStore();

      /// Add multiple todos
      store.dispatch(AddTodosAction([
        Todo('Build app'),
        Todo('Market app'),
        Todo('Sell app'),
        Todo('Retire downeast'),
      ]));

      expect(store.state.todos, isNotEmpty);
      expect(store.state.todos.first.task, equals('Build app'));
      expect(store.state.todos.last.task, equals('Retire downeast'));
      expect(store.state.todos.length, equals(4));
    });

    test('Create/Update/Delete/Toggle TodoAction', () {
      final store = TestUtils.createStore();

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
      final store = TestUtils.createStore();

      /// Change visibility filter
      store.dispatch(SetVisibilityFilter(
        VisibilityFilter.showComplete,
      ));

      expect(
          store.state.visibilityFilter, equals(VisibilityFilter.showComplete));
    });
  });
}
