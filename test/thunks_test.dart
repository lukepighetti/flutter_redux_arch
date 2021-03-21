import 'package:flutter_test/flutter_test.dart';
import 'package:redux_sandbox/service/todo_api.dart';
import 'package:redux_sandbox/state/thunks.dart';

import 'mock_toast_service.dart';
import 'utils.dart';

main() {
  group('Thunks', () {
    test('fetchAdventurousTodos', () async {
      final store = TestUtils.createStore();
      final services =
          TestUtils.createTodoThunkServices(StubErrorFrequency.never);

      final toastService = services.toastService as MockToastService;
      expect(toastService.showErrorToastCalls, isZero);

      /// Initial state
      expect(store.state.fetchingTodos, isFalse);

      /// Is fetching
      store.dispatch(fetchAdventurousTodos(services));

      await store.onChange.where((e) => e.fetchingTodos).first;
      expect(store.state.fetchingTodos, isTrue);

      /// Done fetching
      expect(store.state.fetchingTodos, isFalse);
    }, skip: "need to come up with a way to test thunks");

    test('fetchRiskyTodos', () {
      final store = TestUtils.createStore();
      final services =
          TestUtils.createTodoThunkServices(StubErrorFrequency.never);

      /// Initial state
      expect(store.state.fetchingTodos, isFalse);

      /// Is fetching
      store.dispatch(fetchAdventurousTodos(services));
      expect(store.state.fetchingTodos, isTrue);

      /// Done fetching
      expect(store.state.fetchingTodos, isFalse);
    }, skip: "need to come up with a way to test thunks");
  });
}
