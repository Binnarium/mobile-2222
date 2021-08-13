import 'i-load-information.service.dart';

typedef ILoadOptions<T, U> = ILoadInformationWithOptions<T, U>;

/// Interface to implement a loader with a specific configuration [U], and returns type [T]
abstract class ILoadInformationWithOptions<T, U>
    extends ILoadInformationService<T> {
  final U options;

  const ILoadInformationWithOptions({
    required this.options,
  });
}
