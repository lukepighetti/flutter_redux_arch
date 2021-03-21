import 'package:flutter/material.dart';

/// A service used for displaying toasts.
class ToastService {
  /// The messenger key that should be connected to
  /// [MaterialApp.scaffoldMessengerKey] on first build
  static GlobalKey<ScaffoldMessengerState> messenger;

  /// Display a basic error toast
  Future<void> showErrorToast(String message,
      {VoidCallback onPressRetry}) async {
    assert(messenger != null);

    final foregroundColor = Colors.white;
    final backgroundColor = Colors.red;

    /// Show an error snackbar.
    final snackbar = messenger.currentState.showSnackBar(SnackBar(
      content: Text(
        '$message',
        style: TextStyle(color: foregroundColor),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      action: onPressRetry == null
          ? null
          : SnackBarAction(
              label: 'Retry',
              textColor: foregroundColor,
              onPressed: onPressRetry,
            ),
    ));

    /// Return a future that completes when the snackbar is closed
    return snackbar.closed;
  }
}
