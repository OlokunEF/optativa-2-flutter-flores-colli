abstract class UseCase<P, T> {
  Future<P> execute(T params);
}
