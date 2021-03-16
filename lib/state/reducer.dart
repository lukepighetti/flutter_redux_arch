import 'actions.dart';
import 'models.dart';

AppState todosReducer(AppState state, dynamic action) {
  if (action is CreateTodoAction) {
    return state.copyWith(
      todos: [...state.todos, action.todo],
    );
  } else if (action is DeleteTodoAction) {
    return state.copyWith(
      todos: [
        for (var todo in state.todos)
          if (todo.task != action.todo.task) todo
      ],
    );
  } else if (action is UpdateTodoAction) {
    return state.copyWith(
      todos: [
        for (var todo in state.todos)
          if (todo.task == action.todo.task) action.updatedTodo else todo,
      ],
    );
  } else if (action is SetVisibilityFilter) {
    return state.copyWith(visibilityFilter: action.visibilityFilter);
  } else {
    return state;
  }
}
