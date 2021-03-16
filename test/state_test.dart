import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:redux_sandbox/state/actions.dart';
import 'package:redux_sandbox/state/models.dart';
import 'package:redux_sandbox/state/reducer.dart';

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

    test('Create/Update/Delete TodoAction', () {
      final store = createStore();

      /// Add a todo
      store.dispatch(CreateTodoAction(
        Todo('Build app'),
      ));

      expect(store.state.todos, isNotEmpty);
      expect(store.state.todos.first.task, equals('Build app'));

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
  });
}
