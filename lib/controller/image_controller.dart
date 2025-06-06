import 'package:ai_assistant/helper/my_dialog.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // For base64Decode
import 'dart:typed_data'; // For Uint8List
import 'package:get/get.dart';
import 'package:ai_assistant/apis/apis.dart';

enum Status { none, loading, complete }

class ImageController extends GetxController {
  final textC = TextEditingController();

  final status = Status.none.obs;

  Uint8List? imageData; // To store decoded image data

  Future<void> createAIImage() async {
    if (textC.text.trim().isNotEmpty) {
      status.value = Status.loading;
      imageData = null;

      try {
        final base64Image = await APIs.getAnswer(
          textC.text,
          generateImage: true,
        );

        if (base64Image is String && base64Image.isNotEmpty) {
          // Decode the base64 string to Uint8List
          imageData = base64Decode(base64Image);
          status.value = Status.complete;
        } else {
          // Handle case where image generation failed or returned nothing
          Get.snackbar(
            'Error',
            'Failed to generate image or no image data received.',
          );
          status.value = Status.none; // Reset status if no image
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred: $e');
        status.value = Status.none;
      } finally {
        textC.text = '';
      }
    }
    MyDialog.info('Provide some beautiful image description!');
  }
}
