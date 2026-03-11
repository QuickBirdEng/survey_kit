extension JoinedIterable<T> on Iterable<T> {
  Iterable<T> withSeparator(T separator) {
    return isEmpty
        ? this
        : (expand((element) => [element, separator]).toList());
  }
}
