part of 'scroll_cubit.dart';

@immutable
sealed class ScrollState {}

final class ScrollInitial extends ScrollState {}
final class ScrollStateActive extends ScrollState {}
