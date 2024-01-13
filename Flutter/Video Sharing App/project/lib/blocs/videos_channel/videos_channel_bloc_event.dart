part of 'videos_channel_bloc.dart';

@immutable
sealed class VcBlocEvent {}

class VcBlocUploadEvent extends VcBlocEvent {
  final VideoFile videoFile;
  final VideoInfo videoInfo;

  VcBlocUploadEvent({required this.videoFile, required this.videoInfo});
}
