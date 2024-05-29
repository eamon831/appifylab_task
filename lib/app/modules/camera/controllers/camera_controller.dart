import 'dart:io';

import 'package:camera/camera.dart' as camera_pkg;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '/app/core/base/base_controller.dart';

class CameraController extends BaseController {
  final camController = Rx<camera_pkg.CameraController?>(null);
  List<camera_pkg.CameraDescription>? cameras;
  int selectedCameraIndex = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initializeCamera();
  }

  @override
  void dispose() {
    camController.value?.dispose();
    super.dispose();
  }

  Future<void> initializeCamera() async {
    cameras = await camera_pkg.availableCameras();
    if (cameras!.isNotEmpty) {
      camController.value = camera_pkg.CameraController(
        cameras![selectedCameraIndex],
        camera_pkg.ResolutionPreset.high,
      );
      await camController.value?.initialize();
      camController.refresh();
    }
  }

  Future<void> takePicture() async {
    if (camController.value?.value.isInitialized ?? false) {
      final image = await camController.value!.takePicture();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/${DateTime.now()}.png';
      await image.saveTo(imagePath);
      final imageFile = File(imagePath);

      // TODO(saiful): we can delete the image file from directory after
      // sending it to the server
      Get.back(
        result: imageFile,
      );
    }
  }

  Future<void> switchCamera() async {
    selectedCameraIndex = (selectedCameraIndex + 1) % cameras!.length;
    camController.value = camera_pkg.CameraController(
      cameras![selectedCameraIndex],
      camera_pkg.ResolutionPreset.high,
    );
    await camController.value?.initialize();
    camController.refresh();
  }
}
