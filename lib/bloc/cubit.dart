import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upload_files/bloc/states.dart';
import 'package:upload_files/data/model.dart';
import 'package:upload_files/http/http_helper.dart';


class UploadFilesCubit extends Cubit<UploadFilesStates> {
  UploadFilesCubit() :super(UploadFilesInitialState());

  static UploadFilesCubit get(context) => BlocProvider.of(context);

  UploadFilesModel? searchmodel;
  File? file;
  String? filename;
  String api = 'shoroukfadl975@gmail.com_633a22e9a62ef74629b724a8fb1c34aa08b31411f5a46ab530b7f6832bd8cbb51c526329';


  void pickFiles() async {
    FilePickerResult? xfile = await FilePicker.platform.pickFiles();
    if (xfile != null) {
      file = File(xfile.files.single.path!);
      print("file is picked");
      emit(PickFilesState());
      filename = file!
          .path
          .split('/')
          .last;
      print(filename);
    }
  }

  void uploadFiles({
    String? name
  }) async {
    emit(UploadFilesLoadingState());
    try {
     UploadFilesModel model;
     Map<String,dynamic> map =  await HttpHelper().postMultiPartData(
          Url: "upload",
          data: {
            'x-api-key': api,
            'name': name!
          },
          filepath: file!.path,
          api: api,
          nameinjson: 'file');
       model = UploadFilesModel.fromjson(map);
       print(model.error);
      emit(UploadFilesSuccessState(model));
    } catch (e) {
      print(e.toString());
      emit(UploadFilesErrorState(e.toString()));
    }
  }
}
