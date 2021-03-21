import 'actions.dart';
import 'models.dart';

AppState todosReducer(AppState state, dynamic action) {
  /// Store actions
  if (action is StoreAction) {
    return action.when(
      hydrate: (newState) {
        return newState;
      },
    );
  }

  /// Todo actions
  else if (action is TodoAction) {
    return action.when(
      /// Add multiple todos
      add: (List<Todo> todos) {
        return state.copyWith(
          todos: [...state.todos, ...todos],
        );
      },

      /// Create todo
      create: (Todo todo) {
        return state.copyWith(
          todos: [...state.todos, todo],
        );
      },

      /// Delete todo
      delete: (Todo todo) {
        return state.copyWith(
          todos: [
            for (var e in state.todos)
              if (e.task != todo.task) e
          ],
        );
      },

      /// Fetching todos is in progress
      fetching: (bool fetching) {
        return state.copyWith(
          fetchingTodos: fetching,
        );
      },

      /// Set visibility filter
      filter: (VisibilityFilter filter) {
        return state.copyWith(visibilityFilter: filter);
      },

      /// Toggle todo
      toggle: (Todo todo) {
        return state.copyWith(
          todos: [
            for (var e in state.todos)
              if (e.task == todo.task)
                e.copyWith(completed: !e.completed)
              else
                todo,
          ],
        );
      },

      /// Update todo
      update: (Todo todo, Todo updatedTodo) {
        return state.copyWith(
          todos: [
            for (var e in state.todos)
              if (e.task == todo.task) updatedTodo else todo,
          ],
        );
      },
    );
  }

  /// Unrecognized action
  else {
    return state;
  }
}
