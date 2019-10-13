abstract class UseCase<Param, T> {
  T excute(Param param);
}

abstract class UseCaseWithoutParam<T> {
  T excute();
}
