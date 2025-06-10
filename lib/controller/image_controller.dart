import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert'; // For base64Decode
import 'dart:typed_data'; // For Uint8List
import 'package:ai_assistant/apis/apis.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/helper/my_dialog.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart'; // Import the gal package

enum Status { none, loading, complete }

class ImageController extends GetxController {
  final textC = TextEditingController();

  final status = Status.none.obs;

  Uint8List? imageData; // To store decoded image data

  Future<void> createAIImage() async {
    if (textC.text.trim().isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
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
      }
    } else {
      MyDialog.info('Provide some beautiful image description!');
    }
  }

  // New method to download the image
  Future<void> downloadImage() async {
    if (imageData != null) {
      FocusManager.instance.primaryFocus?.unfocus();
      await Future.delayed(Duration(milliseconds: 50)); // Small delay
      MyDialog.showLoadingDialog();
      try {
        // Save the image to the gallery
        await Gal.putImageBytes(
          imageData!,
          album: appName,
          name: 'ai_image_${DateTime.now().microsecondsSinceEpoch}',
        );
        Get.back(); // Dismiss loading dialog
        MyDialog.success('Image downloaded to gallery!');
      } catch (e) {
        Get.back(); // Dismiss loading dialog
        MyDialog.error('Failed to download image: $e');
      }
    }
    MyDialog.info('Provide some beautiful image description!');
  }

  Future<void> shareImage() async {
    if (imageData != null) {
      MyDialog.showLoadingDialog();
      try {
        // Get the temporary directory
        final directory = await getTemporaryDirectory();
        final filePath =
            '${directory.path}/ai_image${DateTime.now().microsecondsSinceEpoch}.png';
        final file = File(filePath);

        // Write the image data to the temporary file
        await file.writeAsBytes(imageData!);

        // Share the image file
        await Share.shareXFiles([
          XFile(filePath),
        ], text: 'Check out this Amazing image created by $appName App!');

        // Optional: Delete the temporary file after sharing
        await file.delete();

        Get.back(); // Dismiss loading dialog
        // No success dialog needed for sharing, as the share sheet itself indicates success/failure
      } catch (e) {
        Get.back(); // Dismiss loading dialog
        MyDialog.error('Failed to share image: $e');
        log('$e');
      }
    }
  }
}
