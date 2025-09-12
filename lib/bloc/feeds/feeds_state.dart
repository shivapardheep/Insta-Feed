part of 'feeds_bloc.dart';

@immutable
sealed class FeedsState {}

final class FeedsInitial extends FeedsState {}

final class LoadingState extends FeedsState {}

final class LoadedState extends FeedsState {
  final FeedsModel response;

  LoadedState(this.response);
}

final class ErrorState extends FeedsState {
  final String error;

  ErrorState(this.error);
}
