import 'dart:math' show Random;

extension RandomString on Random {
  String generateString({int size = 10}) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final String id = String.fromCharCodes(
      Iterable.generate(
        size,
        (_) => _chars.codeUnitAt(nextInt(_chars.length)),
      ),
    );
    return id;
  }
}
