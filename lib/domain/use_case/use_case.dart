abstract interface class UseCase<Params, Result> {
  Future<Result> execute(Params? params);
}
