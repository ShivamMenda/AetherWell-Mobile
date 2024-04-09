import 'package:aetherwell/controllers/user/user_recomendation_controller.dart';
import 'package:aetherwell/utils/symptoms.dart';
import 'package:aetherwell/views/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class UserRecommendationScreen extends StatelessWidget {
  final UserRecommendationController controller = Get.find();

  UserRecommendationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User recommendation'),
      ),
      drawer: CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MultiSelectDropDown<String>(
              animateSuffixIcon: true,
              hintColor: Get.theme.primaryColor,
              borderColor: Get.theme.primaryColor,
              fieldBackgroundColor: Get.theme.colorScheme.background,
              focusedBorderColor: Get.theme.primaryColor,
              searchBackgroundColor: Get.theme.colorScheme.background,
              optionsBackgroundColor: Get.theme.colorScheme.background,
              dropdownBackgroundColor: Get.theme.colorScheme.background,
              options: Symptoms.symptoms
                  .map(
                    (e) => ValueItem(
                      label: e,
                      value: e,
                    ),
                  )
                  .toList(),
              onOptionSelected: controller.onOptionSelected,
              searchEnabled: true,
              selectionType: SelectionType.multi,
              chipConfig: const ChipConfig(
                autoScroll: true,
                wrapType: WrapType.wrap,
              ),
              padding: const EdgeInsets.all(10),
            ),
          ),
          Obx(
            () => controller.isLoading.value
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        controller.currentTip.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          ElevatedButton(
            onPressed: controller.submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Get.theme.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(fontSize: 25),
              padding: const EdgeInsets.all(25),
            ),
            child: Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
