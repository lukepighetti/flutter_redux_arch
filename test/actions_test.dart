import 'package:flutter_test/flutter_test.dart';
import 'package:redux_sandbox/state/actions.dart';
import 'package:redux_sandbox/state/models.dart';

import 'utils.dart';

main() {
  group('Actions', () {
    test('TodoAction.fetching', () {
      final store = TestUtils.createStore();

      /// Initial state
      expect(store.state.fetchingTodos, isFalse);

      /// Is fetching
      store.dispatch(TodoAction.fetching(true));
      expect(store.state.fetchingTodos, isTrue);

      /// Done fetching
      store.dispatch(TodoAction.fetching(false));
      expect(store.state.fetchingTodos, isFalse);
    });

    test('TodoAction.add', () {
      final store = TestUtils.createStore();

      /// Add multiple todos
      store.dispatch(TodoAction.add([
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

    test('TodoAction.create, update, delete, toggle', () {
      final store = TestUtils.createStore();

      /// Add a todo
      store.dispatch(TodoAction.create(
        Todo('Build app'),
      ));

      expect(store.state.todos, isNotEmpty);
      expect(store.state.todos.first.task, equals('Build app'));
      expect(store.state.todos.first.completed, isFalse);

      /// Toggle a todo
      store.dispatch(TodoAction.toggle(
        Todo('Build app'),
      ));

      expect(store.state.todos, isNotEmpty);
      expect(store.state.todos.first.completed, isTrue);

      /// Update a todo
      store.dispatch(TodoAction.update(
        Todo('Build app'),
        Todo('Test app'),
      ));

      expect(store.state.todos, isNotEmpty);
      expect(store.state.todos.first.task, equals('Test app'));

      /// Delete a todo
      store.dispatch(TodoAction.delete(
        Todo('Test app'),
      ));

      expect(store.state.todos, isEmpty);
    });

    test('TodoAction.filter', () {
      final store = TestUtils.createStore();

      /// Change visibility filter
      store.dispatch(TodoAction.filter(
        VisibilityFilter.showComplete,
      ));

      expect(
          store.state.visibilityFilter, equals(VisibilityFilter.showComplete));
    });
  });
}
