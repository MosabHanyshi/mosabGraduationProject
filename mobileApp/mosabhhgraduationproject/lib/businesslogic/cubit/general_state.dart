abstract class GeneralState<T> {}

class LoadingState<T> extends GeneralState<T> {}

class LoadedState<T> extends GeneralState<T> {
  final T data;

  LoadedState(this.data);
}

class ErrorState<T> extends GeneralState<T> {
  final String error;

  ErrorState(this.error);
}

class EmptyState<T> extends GeneralState<T> {}

class InitialState<T> extends GeneralState<T> {}