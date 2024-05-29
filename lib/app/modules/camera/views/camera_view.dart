import 'package:camera/camera.dart' as camera_pkg;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/base/base_view.dart';
import '/app/modules/camera/controllers/camera_controller.dart';

class CameraView extends BaseView<CameraController> {
  CameraView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar();
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () {
        return Stack(
          children: [
            controller.camController.value != null &&
                    controller.camController.value!.value.isInitialized
                ? camera_pkg.CameraPreview(controller.camController.value!)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: controller.isRecording
                        ? controller.stopVideoRecording
                        : controller.startVideoRecording,
                    child: Icon(
                      controller.isRecording ? Icons.stop : Icons.videocam,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: controller.takePicture,
                    child: const Icon(
                      Icons.camera,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: controller.switchCamera,
                    child: const Icon(
                      Icons.switch_camera,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
