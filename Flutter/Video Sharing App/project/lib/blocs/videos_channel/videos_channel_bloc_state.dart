part of 'videos_channel_bloc.dart';

@immutable
sealed class VcBlocState {}

final class VcBlocInitialState extends VcBlocState {}

final class VcBlocUploadDoneState extends VcBlocState {}
