import 'actions.dart';
import 'models.dart';

AppState todosReducer(AppState state, dynamic action) {
  /// Create todo
  if (action is CreateTodoAction) {
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
  } else {
    return state;
  }
}
