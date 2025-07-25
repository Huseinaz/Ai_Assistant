import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ai_assistant/main.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/controller/translate_controller.dart';

class LanguageSheet extends StatefulWidget {
  const LanguageSheet({super.key, required this.c, required this.s});

  final TranslateController c;
  final RxString s;

  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<LanguageSheet> {
  final _search = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mq.height * 0.5,
      padding: EdgeInsets.only(
        left: mq.width * 0.04,
        right: mq.width * 0.04,
        top: mq.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),

      child: Column(
        children: [
          TextFormField(
            // controller: _c.resultC,
            onChanged: (s) => _search.value = s,

            onTapOutside: (e) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.translate_rounded,
                color: Theme.of(context).buttonColor,
              ),
              hintText: 'Search Language...',
              hintStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),

          Expanded(
            child: Obx(() {
              final List<String> list =
                  _search.isEmpty
                      ? widget.c.lang
                      : widget.c.lang
                          .where((e) => e.toLowerCase().contains(_search.value))
                          .toList();

              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: list.length,
                padding: EdgeInsets.only(top: mq.height * 0.02, left: 6),
                itemBuilder: (ctx, i) {
                  return InkWell(
                    onTap: () {
                      widget.s.value = list[i];
                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: mq.height * 0.02),
                      child: Text(list[i]),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
