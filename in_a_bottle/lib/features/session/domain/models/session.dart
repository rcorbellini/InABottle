class Session<T> {
  final T payload;
  final String token;

  Session({required this.payload, required this.token});
}
