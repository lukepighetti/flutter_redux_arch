import 'dart:convert';

import 'package:redux_remote_devtools/redux_remote_devtools.dart';

import 'state/decoder.dart';

/// A custom action encoder that also cleans generated `freezed` toString()
String actionEncoder(dynamic action) {
  /// Gets a type name for the action, based on the class name or value
  String getActionType(dynamic action) {
    if (action.toString().contains('Instance of')) {
      return action.runtimeType.toString();
    } else if (action.toString().contains('(')) {
      /// Remove `freezed` toString() data class payload
      return action.toString().replaceAll(RegExp(r'\(.*\)$'), '');
    } else {
      return action.toString();
    }
  }

  try {
    return jsonEncode({'type': getActionType(action), 'payload': action});
  } on Error {
    return jsonEncode({'type': getActionType(action)});
  }
}

/// A custom action decoder that handles our actions
ActionDecoder actionDecoder = (dynamic payload) {
  final map = payload as Map<String, dynamic>;
  final actionGroup = map['type'].split('.').first;
  final actionPayload = map['payload'];

  return decoder(actionGroup, actionPayload);
};
