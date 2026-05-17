abstract class RfqState {}

class RfqInitial extends RfqState {}

class RfqLoading extends RfqState {}

class RfqSuccess extends RfqState {
  final String message;
  RfqSuccess(this.message);
}

class RfqError extends RfqState {
  final String message;

  RfqError(this.message);
}
