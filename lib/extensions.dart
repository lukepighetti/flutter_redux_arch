extension FutureX<T> on Future<T> {
  /// Gracefully return `null` if this [Future] throws an error.
  Future<T> ignoreErrors() async {
    try {
      return await this;
    } catch (e) {
      print('Warning: Ignored $e');
      return null;
    }
  }
}
