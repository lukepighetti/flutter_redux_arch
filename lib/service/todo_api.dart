import 'dart:async';
import 'dart:math';

import 'package:redux_sandbox/state/models.dart';

/// A mock API for fetching todos
class TodoApi {
  TodoApi({
    this.throwRandomNetworkErrors = StubErrorFrequency.sometimes,
  });

  /// If [TodoApi] should simulate a poor internet connection by
  /// throwing random network errors.
  final StubErrorFrequency throwRandomNetworkErrors;

  /// Simulate a poor internet connection
  bool _shouldThrowError() {
    switch (throwRandomNetworkErrors) {
      case StubErrorFrequency.always:
        return true;

      case StubErrorFrequency.sometimes:
        return Random().nextBool();

      case StubErrorFrequency.never:
      default:
        return false;
    }
  }

  /// Get todos from a mock network source.
  Future<List<Todo>> getTodos(TodoType type) async {
    await Future.delayed(Duration(seconds: 1));

    final shouldThrowError = _shouldThrowError();

    switch (type) {
      case TodoType.adventurous:
        if (shouldThrowError)
          throw TodoApiError('Failed to fetch adventurous todos.');

        return [
          Todo('Build a canoe'),
          Todo('Paddle the Allagash'),
          Todo('Build a log cabin'),
        ];

      case TodoType.risky:
        if (shouldThrowError)
          throw TodoApiError('Failed to fetch risky todos.');

        return [
          Todo('Make popcorn'),
          Todo('Netflix & chill'),
        ];

      default:
        return [];
    }
  }
}

enum TodoType { adventurous, risky }

class TodoApiError extends Error {
  /// An error thrown by [TodoApi]
  TodoApiError(this.message);

  final String message;
}

enum StubErrorFrequency {
  /// Always throw a stub error
  always,

  /// Sometimes throw a stub error, approx 50% of the time
  sometimes,

  /// Never throw stub errors
  never,
}
