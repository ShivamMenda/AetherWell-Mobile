import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:aetherwell/models/predictions.dart';
import 'package:aetherwell/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:http/http.dart' as http;

class UserRecommendationController extends GetxController {
  var selectedItems = <String>[].obs;
  var currentTip = ''.obs;

  List<String> healthTips = [
    "Drink plenty of water throughout the day.",
    "Eat a variety of fruits and vegetables daily.",
    "Get at least 7-8 hours of sleep each night.",
    "Exercise regularly for at least 30 minutes.",
    "Limit consumption of processed foods and sugary drinks.",
    "Practice portion control to avoid overeating.",
    "Reduce stress through relaxation techniques like meditation or yoga.",
    "Avoid smoking and limit alcohol consumption.",
    "Maintain good hygiene by washing hands frequently.",
    "Schedule regular check-ups with your healthcare provider.",
    "Take breaks from screens to rest your eyes.",
    "Include healthy fats like avocados and nuts in your diet.",
    "Limit intake of sodium and opt for low-sodium options.",
    "Incorporate strength training into your exercise routine.",
    "Practice mindfulness to improve mental well-being.",
    "Prioritize self-care activities for stress relief.",
    "Engage in activities that bring you joy and relaxation.",
    "Maintain a healthy weight through balanced nutrition and exercise.",
    "Limit exposure to environmental toxins.",
    "Stay connected with friends and loved ones for emotional support."
  ];

  RxBool isLoading = false.obs;
  void onOptionSelected(List<ValueItem<String>> selectedOptions) {
    selectedItems.value = selectedOptions.map((e) => e.value!).toList();
  }

  void onOptionRemoved(index, option) {
    selectedItems.removeAt(index);
  }

  Future<void> displayTip() async {
    while (isLoading.value) {
      final random = Random();
      await Future.delayed(
        const Duration(seconds: 2),
      );
      final index = random.nextInt(healthTips.length);
      currentTip.value = healthTips[index];
    }
  }

  Future<List<Pridections>> getResponse() async {
    final Uri url = Uri.parse('$kFlaskApiUrl/predict');
    final body = jsonEncode(
      {
        'symptoms': selectedItems.map((element) => element).toList(),
      },
    );

    print(body);
    final response = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    // replace \u000b with whitespace
    print(response.body);
    final data = response.body.replaceAll(RegExp(r'\\u000b'), ' ');

    final decodedData = jsonDecode(data) as Map<String, dynamic>;
    final decodedResult = decodedData['result'] as List<dynamic>;
    final List<Pridections> result =
        decodedResult.map((e) => Pridections.fromJson(e)).toList();
    return result;
  }

  void submit() async {
    if (selectedItems.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select at least one symptom',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
      return;
    }
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    displayTip();
    final pridections = await getResponse();
    isLoading.value = false;
    Get.defaultDialog(
      title: 'Diagnosis',
      content: SizedBox(
        height: 300,
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (final pridection in pridections)
                ListTile(
                  title: Text(pridection.diagnose),
                  subtitle: Text('Prediction: ${pridection.prediction}'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
