import 'models.dart';

class CreateTodoAction {
  /// Creates a todo via [todosReducer]
  CreateTodoAction(this.todo);

  final Todo todo;
}

class DeleteTodoAction {
  /// Deletes a todo via [todosReducer]
  DeleteTodoAction(this.todo);

  final Todo todo;
}

class UpdateTodoAction {
  /// Updates a todo via [todosReducer]
  UpdateTodoAction(this.todo, this.update);

  final Todo todo;

  final Todo Function(Todo) update;

  Todo get updatedTodo => update(todo);
}

class SetVisibilityFilter {
  /// Set the current visibility filter via [todosReducer]
  SetVisibilityFilter(this.visibilityFilter);

  final VisibilityFilter visibilityFilter;
}
