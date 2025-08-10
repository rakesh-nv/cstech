import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/LanguageSelection_controller.dart';

class LanguageSelectionScreen extends StatelessWidget {
  final LanguageSelectionController controller =
      Get.put(LanguageSelectionController());

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Choose Your Language',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemCount: controller.languages.length,
                itemBuilder: (context, index) {
                  final lang = controller.languages[index];
                  return Obx(
                    () {
                      return RadioListTile<String>(
                        value: lang['name']!,
                        groupValue: controller.setLanguage.value,
                        title: Text(
                          lang['name']!,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(lang['subtitle']!),
                        activeColor: Colors.black,
                        onChanged: (value) {
                          controller.getLanguage(value);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('AuthScreen');
                  Get.snackbar(
                    'Language Selected',
                    'You selected: ${controller.setLanguage.value}',
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.blue.shade100,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Select',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
