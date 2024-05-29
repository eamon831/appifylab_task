import 'dart:io';
import 'package:camera/camera.dart' as camera_pkg;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '/app/core/base/base_controller.dart';

class CameraController extends BaseController {
  final camController = Rx<camera_pkg.CameraController?>(null);
  List<camera_pkg.CameraDescription>? cameras;
  int selectedCameraIndex = 0;
  bool isRecording = false;

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

  Future<void> startVideoRecording() async {
    if (camController.value?.value.isInitialized ?? false && !isRecording) {
      final directory = await getApplicationDocumentsDirectory();
      final videoPath = '${directory.path}/${DateTime.now()}.mp4';
      await camController.value?.startVideoRecording();
      isRecording = true;
      camController.refresh();
    }
  }

  Future<void> stopVideoRecording() async {
    if (isRecording) {
      final video = await camController.value?.stopVideoRecording();
      isRecording = false;
      camController.refresh();
      Get.back(
        result: File(video!.path),
      );
    }
  }
}
