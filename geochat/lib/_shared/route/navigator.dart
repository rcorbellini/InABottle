abstract class Navigator {
  Future<T> navigateTo<T>(String route, {Map<String, dynamic> params});

  void pop();
}
