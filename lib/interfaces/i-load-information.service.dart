abstract class ILoadInformationService<T> {
  const ILoadInformationService();

  Future<T> load();
}
