import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/widget/custom_button.dart';
import 'package:ai_assistant/widget/custom_loading.dart';
import 'package:ai_assistant/controller/image_controller.dart';

class ImageFeature extends StatefulWidget {
  const ImageFeature({super.key});

  @override
  State<ImageFeature> createState() => _ImageFeatureState();
}

class _ImageFeatureState extends State<ImageFeature> {
  final _c = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Image Creator')),

      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: mq.height * 0.02,
          bottom: mq.height * 0.1,
          left: mq.width * 0.04,
          right: mq.width * 0.04,
        ),
        children: [
          // Text field
          TextFormField(
            controller: _c.textC,
            textAlign: TextAlign.center,
            minLines: 2,
            maxLines: null,
            onTapOutside: (e) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              hintText:
                  'Imagine something wonderful & innovative\nType here and I will create for you',
              hintStyle: TextStyle(fontSize: 13.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),

          // AI Image Display Area
          Container(
            height: mq.height * 0.5, // Fixed height for image display
            alignment: Alignment.center,
            child: Obx(() => _aiImage()),
          ),

          // Button
          CustomButton(onTap: _c.createAIImage, text: 'Create '),
        ],
      ),
    );
  }

  Widget _aiImage() {
    switch (_c.status.value) {
      case Status.none:
        return Lottie.asset(
          'assets/lottie/ai_play.json',
          height: mq.height * 0.3,
        );
      case Status.loading:
        return CustomLoading();
      case Status.complete:
        // Display the image from Uint8List if available
        if (_c.imageData != null) {
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Image.memory(
              _c.imageData!,
              fit: BoxFit.contain,
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Text('Failed to load image.')),
            ),
          );
        } else {
          // Fallback if imageData is null even after status.complete
          return const Center(child: Text('No image generated.'));
        }
    }
  }
}
