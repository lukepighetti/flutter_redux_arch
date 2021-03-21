import 'package:redux_dev_tools/redux_dev_tools.dart';

import 'actions.dart';
import 'models.dart';

AppState todosReducer(AppState state, dynamic action) {
  /// Hydrate the store
  if (action is HydrateStore) {
    return action.persistedState;
  }

  /// Fetching todos is in progress
  else if (action is SetFetchingTodosAction) {
    return state.copyWith(
      fetchingTodos: action.fetching,
    );
  }

  /// Add multiple todos
  else if (action is AddTodosAction) {
    return state.copyWith(
      todos: [...state.todos, ...action.todos],
    );
  }

  /// Create todo
  else if (action is CreateTodoAction) {
    return state.copyWith(
      todos: [...state.todos, action.todo],
    );
  }

  /// Delete todo
  else if (action is DeleteTodoAction) {
    return state.copyWith(
      todos: [
        for (var todo in state.todos)
          if (todo.task != action.todo.task) todo
      ],
    );
  }

  /// Update todo
  else if (action is UpdateTodoAction) {
    return state.copyWith(
      todos: [
        for (var todo in state.todos)
          if (todo.task == action.todo.task) action.updatedTodo else todo,
      ],
    );
  }

  /// Toggle todo
  else if (action is ToggleTodoAction) {
    return state.copyWith(
      todos: [
        for (var todo in state.todos)
          if (todo.task == action.todo.task)
            todo.copyWith(completed: !todo.completed)
          else
            todo,
      ],
    );
  }

  /// Set visibility filter
  else if (action is SetVisibilityFilter) {
    return state.copyWith(visibilityFilter: action.visibilityFilter);
  }

  /// Gracefully ignore dev tools actions
  else if (action is DevToolsAction) {
    return state;
  }

  /// Unsupported action or middleware action
  else {
    return state;
  }
}
