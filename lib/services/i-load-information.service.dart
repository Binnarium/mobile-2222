abstract class ILoadInformationService<T> {
  Future<T> load();

  const ILoadInformationService();
}
