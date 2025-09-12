part of 'feeds_bloc.dart';

@immutable
sealed class FeedsEvent {}

final class FetchFeeds extends FeedsEvent {}
