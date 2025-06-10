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
  // Declare a FocusNode
  late FocusNode _textFocusNode; // Declare it here

  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode(); // Initialize in initState
  }

  @override
  void dispose() {
    _textFocusNode.dispose(); // Dispose in dispose method
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Image Creator'),

        // Share Button
        actions: [
          Obx(
            () =>
                _c.status.value == Status.complete
                    ? IconButton(
                      padding: EdgeInsets.only(right: 6),
                      onPressed: () {
                        _c.shareImage();
                      },
                      icon: const Icon(Icons.share),
                    )
                    : SizedBox(),
          ),
        ],
      ),

      floatingActionButton: Obx(
        () =>
            _c.status.value == Status.complete
                ? Padding(
                  padding: EdgeInsets.only(right: 6, bottom: 6),
                  child: FloatingActionButton(
                    onPressed: () {
                      _textFocusNode.unfocus();
                      _c.downloadImage();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    backgroundColor: Colors.blue,
                    child: const Icon(
                      Icons.save_alt_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                )
                : SizedBox(),
      ),

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
            focusNode: _textFocusNode, // Assign the focus node here
            textAlign: TextAlign.center,
            minLines: 2,
            maxLines: null,
            onTapOutside:
                (e) => _textFocusNode.unfocus(), // Use the focus node here
            decoration: InputDecoration(
              hintText:
                  'Imagine something wonderful & innovative\nType here and I will create for you 😃',
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
          return const Center(child: Text('No image generated.'));
        }
    }
  }
}
