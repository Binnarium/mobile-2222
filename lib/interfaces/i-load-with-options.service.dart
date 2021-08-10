import 'i-load-information.service.dart';

/// Interface to implement a loader with a specific configuration [U], and returns type [T]
abstract class ILoadInformationWithOptions<T, U>
    extends ILoadInformationService<T> {
  final U options;

  const ILoadInformationWithOptions({
    required this.options,
  });
}
