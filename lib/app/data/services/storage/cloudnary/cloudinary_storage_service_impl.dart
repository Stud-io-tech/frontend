import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_fome/app/utils/env/env.dart';
import 'cloudinary_storage_service.dart';

class CloudinaryStorageServiceImpl implements CloudinaryStorageService {
  final cloudinary = Cloudinary.signedConfig(
    apiKey: Env.cloudinaryApiKey,
    apiSecret: Env.cloudinaryApiSecret,
    cloudName: Env.cloudinaryCloudName,
  );

  Future<String?>? _uploadLocal(FileType fileType, CloudinaryResourceType cloudinaryType,
      String folder, String path) async {
    final file = File(path);
    final bytes = await file.readAsBytes();
    final response = await cloudinary.upload(
      fileBytes: bytes,
      resourceType: cloudinaryType,
      folder: folder,
      fileName: "document_${DateTime.now().millisecondsSinceEpoch}",
    );
    return response.isSuccessful ? response.secureUrl : null;
  }

  @override
  Future<String?> uploadLocalDocument(String path) async {
    return await _uploadLocal(
        FileType.any, CloudinaryResourceType.auto, "documents", path);
  }
}
