import 'dart:ui';

import 'package:redux_sandbox/service/toast_service.dart';

class MockToastService implements ToastService {
  var showErrorToastCalls = 0;

  @override
  Future<void> showErrorToast(String message,
      {VoidCallback onPressRetry}) async {
    showErrorToastCalls++;
  }
}
