
import 'package:upload_files/data/model.dart';

abstract class UploadFilesStates{}
class UploadFilesInitialState extends UploadFilesStates{}
class PickFilesState extends UploadFilesStates{}
class UploadFilesLoadingState extends UploadFilesStates{}
class UploadFilesSuccessState extends UploadFilesStates{
  final UploadFilesModel model;
  UploadFilesSuccessState(this.model);

}
class UploadFilesErrorState extends UploadFilesStates{
  String error;
  UploadFilesErrorState(this.error);
}
