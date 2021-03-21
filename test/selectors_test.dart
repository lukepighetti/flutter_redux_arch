import 'package:flutter_test/flutter_test.dart';
import 'package:redux_sandbox/state/actions.dart';
import 'package:redux_sandbox/state/models.dart';
import 'package:redux_sandbox/state/selectors.dart';

import 'utils.dart';

main() {
  group('Selectors', () {
    test(
        'completeTodosSelector, incompleteTodosSelector, scheduledTodosSelector',
        () {
      final store = TestUtils.createStore();
      final now = store.state.now;

      store.dispatch(TodoAction.create(
        Todo(
          'Foo',
          completed: true,
          due: now.add(Duration(days: 1)),
        ),
      ));

      store.dispatch(TodoAction.create(
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
