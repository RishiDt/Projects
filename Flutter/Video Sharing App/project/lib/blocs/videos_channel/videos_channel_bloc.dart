import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_sharing_app/data/dataSource.dart';
import 'package:video_sharing_app/entities/video_info.dart';

import '../../entities/video_File.dart';

part 'videos_channel_bloc_event.dart';
part 'videos_channel_bloc_state.dart';

class VcBloc extends Bloc<VcBlocEvent, VcBlocState> {
  //use getIt
  DataSource ds = DataSource.getInstance();

  VcBloc() : super(VcBlocInitialState()) {
    on<VcBlocUploadEvent>(uploadHandler);
  }

  void uploadHandler(event, emit) {
    if (event is VcBlocUploadEvent) {
      ds.uplaodVideo(event.videoInfo, event.videoFile);
      emit(VcBlocUploadDoneState());
    }
  }
}
