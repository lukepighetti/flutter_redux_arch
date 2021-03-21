import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'actions.freezed.dart';
part 'actions.g.dart';

@freezed
abstract class StoreAction with _$StoreAction {
  /// Hydrates the Redux store with persisted AppState
  factory StoreAction.hydrate(AppState newState) = _StoreActionHydrate;

  factory StoreAction.fromJson(Map<String, dynamic> json) =>
      _$StoreActionFromJson(json);
}

@freezed
abstract class TodoAction with _$TodoAction {
  /// Creates a todo
  factory TodoAction.create(Todo todo) = _TodoActionCreate;

  /// Add multiple todos
  factory TodoAction.add(List<Todo> todos) = _TodoActionAdd;

  /// Delete a todo
  factory TodoAction.delete(Todo todo) = _TodoActionDelete;

  /// Update a todo
  factory TodoAction.update(Todo todo, Todo updatedTodo) = _TodoActionUpdate;

  /// Toggle a todo
  factory TodoAction.toggle(Todo todo) = _TodoActionToggle;

  /// Filter a todo
  factory TodoAction.filter(VisibilityFilter filter) = _TodoActionFilter;

  /// Todos are fetching
  factory TodoAction.fetching(bool fetching) = _TodoActionFetching;

  factory TodoAction.fromJson(Map<String, dynamic> json) =>
      _$TodoActionFromJson(json);
}
