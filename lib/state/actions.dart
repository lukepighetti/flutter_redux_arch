import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'actions.freezed.dart';
part 'actions.g.dart';

@freezed
abstract class CreateTodoAction with _$CreateTodoAction {
  /// Creates a todo via [todosReducer]
  factory CreateTodoAction(
    Todo todo,
  ) = _CreateTodoAction;

  factory CreateTodoAction.fromJson(Map<String, dynamic> json) =>
      _$CreateTodoActionFromJson(json);
}

@freezed
abstract class DeleteTodoAction with _$DeleteTodoAction {
  /// Deletes a todo via [todosReducer]
  factory DeleteTodoAction(
    Todo todo,
  ) = _DeleteTodoAction;

  factory DeleteTodoAction.fromJson(Map<String, dynamic> json) =>
      _$DeleteTodoActionFromJson(json);
}

class UpdateTodoAction {
  /// Updates a todo via [todosReducer]
  UpdateTodoAction(this.todo, this.updatedTodo);

  final Todo todo;

  final Todo updatedTodo;
}

@freezed
abstract class ToggleTodoAction with _$ToggleTodoAction {
  /// Deletes a todo via [todosReducer]
  factory ToggleTodoAction(
    Todo todo,
  ) = _ToggleTodoAction;

  factory ToggleTodoAction.fromJson(Map<String, dynamic> json) =>
      _$ToggleTodoActionFromJson(json);
}

@freezed
abstract class SetVisibilityFilter with _$SetVisibilityFilter {
  /// Set the current visibility filter via [todosReducer]
  factory SetVisibilityFilter(
    final VisibilityFilter visibilityFilter,
  ) = _SetVisibilityFilter;

  factory SetVisibilityFilter.fromJson(Map<String, dynamic> json) =>
      _$SetVisibilityFilterFromJson(json);
}
