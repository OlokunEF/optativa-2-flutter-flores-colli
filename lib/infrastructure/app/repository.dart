abstract class Repository<P,T> {
  Future<P> execute(T params);
}
