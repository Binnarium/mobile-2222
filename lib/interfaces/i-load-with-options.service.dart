import 'i-load-information.service.dart';

typedef ILoadOptions<T, U> = ILoadInformationWithOptions<T, U>;

/// Interface to implement a loader with a specific configuration [U], and returns type [T]
@Deprecated('Use ILoadOptions instead')
abstract class ILoadInformationWithOptions<T, U>
    extends ILoadInformationService<T> {
  const ILoadInformationWithOptions({
    required this.options,
  });
  final U options;
}
