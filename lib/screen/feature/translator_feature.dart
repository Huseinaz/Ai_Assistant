import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ai_assistant/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/widget/custom_button.dart';
import 'package:ai_assistant/widget/custom_loading.dart';
import 'package:ai_assistant/widget/language_sheet.dart';
import 'package:ai_assistant/controller/image_controller.dart';
import 'package:ai_assistant/controller/translate_controller.dart';

class TranslatorFeature extends StatefulWidget {
  const TranslatorFeature({super.key});

  @override
  State<TranslatorFeature> createState() => _TranslatorFeatureState();
}

class _TranslatorFeatureState extends State<TranslatorFeature> {
  final _c = TranslateController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multi Language Translator')),

      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: mq.height * 0.02,
          bottom: mq.height * 0.1,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // From Language
              InkWell(
                onTap: () => Get.bottomSheet(LanguageSheet(c: _c, s: _c.from)),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Container(
                  height: 50,
                  width: mq.width * 0.4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).buttonColor),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Obx(
                    () => Text(_c.from.isEmpty ? 'Auto' : _c.from.value),
                  ),
                ),
              ),

              // Swipe Language Button
              IconButton(
                onPressed: _c.swapLanguages,
                icon: Obx(
                  () => Icon(
                    CupertinoIcons.repeat,
                    color:
                        _c.to.isNotEmpty && _c.from.isNotEmpty
                            ? Theme.of(context).buttonColor
                            : Colors.grey,
                  ),
                ),
              ),

              // To Language
              InkWell(
                onTap: () => Get.bottomSheet(LanguageSheet(c: _c, s: _c.to)),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Container(
                  height: 50,
                  width: mq.width * 0.4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).buttonColor),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Obx(() => Text(_c.to.isEmpty ? 'To' : _c.to.value)),
                ),
              ),
            ],
          ),

          // Text field
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: mq.width * 0.04,
              vertical: mq.height * 0.035,
            ),
            child: TextFormField(
              controller: _c.textC,
              minLines: 5,
              maxLines: null,
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                hintText: 'Translate anything you want...',
                hintStyle: TextStyle(fontSize: 13.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),

          // Result field
          Obx(() => _translateResult()),

          SizedBox(height: mq.height * 0.04),

          CustomButton(onTap: _c.translate, text: 'Translate'),
        ],
      ),
    );
  }

  Widget _translateResult() => switch (_c.status.value) {
    Status.none => SizedBox(),
    Status.complete => Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.width * 0.04),
      child: TextFormField(
        controller: _c.resultC,
        maxLines: null,
        onTapOutside: (e) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    ),
    Status.loading => Align(child: CustomLoading()),
  };
}
