import 'i-load-information.service.dart';

abstract class ILoadInformationWithOptions<T, U>
    extends ILoadInformationService<T> {
  final U options;

  const ILoadInformationWithOptions({
    required this.options,
  });
}
