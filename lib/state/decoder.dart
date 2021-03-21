import 'actions.dart';

/// Registering an action here will allow us to dispatch it in Dev Tools
dynamic decoder(String actionGroup, Map payload) {
  switch (actionGroup) {
    case 'StoreAction':
      return StoreAction.fromJson(payload);

    case 'TodoAction':
    default:
      return TodoAction.fromJson(payload);
  }
}
