import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
abstract class AppState with _$AppState {
  factory AppState({
    @Default([]) List<Todo> todos,
    @Default(VisibilityFilter.showAll) VisibilityFilter visibilityFilter,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);
}

@freezed
abstract class Todo with _$Todo {
  factory Todo(
    String task, {
    @Default(false) bool completed,
    DateTime due,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

enum VisibilityFilter {
  showAll,
  showComplete,
  showIncomplete,
}
