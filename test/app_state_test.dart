import 'package:flutter_test/flutter_test.dart';
import 'package:redux_sandbox/state/models.dart';

import 'utils.dart';

main() {
  group('AppState', () {
    test('initial state', () {
      final store = TestUtils.createStore();

      expect(store.state.todos, isEmpty);
      expect(store.state.visibilityFilter, equals(VisibilityFilter.showAll));
    });
  });
}
