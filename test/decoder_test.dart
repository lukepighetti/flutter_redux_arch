import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:redux_sandbox/remote_dev_tools.dart';
import 'package:redux_sandbox/state/actions.dart';

main() {
  group('decoder', () {
    test('with normal payload', () {
      final payload = '''
        {
          "type": "TodoAction.create",
          "payload": {
            "todo": {
              "task": "add one",
              "completed": false,
              "due": null
            },
            "runtimeType": "create"
          }
        }
      ''';

      final action = actionDecoder(jsonDecode(payload));
      expect(action is TodoAction, isTrue);

      final todoAction = action as TodoAction;
      final createAction = todoAction.maybeWhen(
        create: (e) => e,
        orElse: () => null,
      );

      expect(createAction, isNotNull);
      expect(createAction.task, equals('add one'));
      expect(createAction.completed, isFalse);
      expect(createAction.due, isNull);
    });

    test('with missing runtimeType in payload', () {
      final payload = '''
      {
        "type": "TodoAction.create",
        "payload": {
          "todo": {
            "task": "add one",
            "completed": false,
            "due": null
          }
        }
      }      
      ''';

      final action = actionDecoder(jsonDecode(payload));
      expect(action is TodoAction, isTrue);

      final todoAction = action as TodoAction;
      final createAction = todoAction.maybeWhen(
        create: (e) => e,
        orElse: () => null,
      );

      expect(createAction, isNotNull);
      expect(createAction.task, equals('add one'));
      expect(createAction.completed, isFalse);
      expect(createAction.due, isNull);
    });
  });
}
