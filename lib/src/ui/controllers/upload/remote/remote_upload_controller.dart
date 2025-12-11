// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';

import 'package:my_fome/src/data/services/storage/cloudnary/cloudinary_storage_service.dart';

part 'remote_upload_controller.g.dart';

class RemoteUploadController = RemoteUploadControllerBase
    with _$RemoteUploadController;

abstract class RemoteUploadControllerBase with Store {
  final CloudinaryStorageService cloudinaryStorageService;
  RemoteUploadControllerBase({
    required this.cloudinaryStorageService,
  });

  @observable
  bool isLoading = false;

  Future<String?> uploadOrderPDF(String file) async {
    isLoading = true;
    final urlPdf = await cloudinaryStorageService.uploadLocalDocument(file);
    isLoading = false;
    return urlPdf;
  }
}
