import 'package:aetherwell/models/doctor.dart';
import 'package:aetherwell/routes/app_routes.dart';
import 'package:aetherwell/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserRecommendationSelection extends StatefulWidget {
  final List<String> diseasesPrediction;

  const UserRecommendationSelection({
    Key? key,
    required this.diseasesPrediction,
  }) : super(key: key);

  @override
  _UserRecommendationSelectionState createState() =>
      _UserRecommendationSelectionState();
}

class _UserRecommendationSelectionState
    extends State<UserRecommendationSelection> {
  int? selectedIndex;
  RxBool isLoading = false.obs;

  Future<Map<String, String>> getDoctorList() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    final url = Uri.parse('$kNodeApiUrl/api/v1/users/getAllDoctors');
    final response = await http.get(url, headers: header);
    final docList = <String, String>{};
    final responseData =
        (jsonDecode(response.body) as Map<String, dynamic>)['doctors'] as List;
    for (final doctor in responseData) {
      docList[doctor['_id']] = doctor['name'];
    }
    return docList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a Disease"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.diseasesPrediction.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                textColor: index < 6
                    ? (index < 3 ? Colors.red : Colors.amber)
                    : Colors.white70,
                title: Text(
                  widget.diseasesPrediction[index],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                leading: Checkbox(
                  activeColor: index < 6
                      ? (index < 3 ? Colors.red : Colors.amber)
                      : Colors.white70,
                  value: selectedIndex == index,
                  onChanged: (bool? value) {
                    if (value != null) {
                      setState(() {
                        if (value) {
                          selectedIndex = index; // Set this item as selected
                        } else {
                          selectedIndex = null; // Deselect this item
                        }
                      });
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.check),
        onPressed: () {
          if (selectedIndex != null) {
            _showConfirmationDialog(widget.diseasesPrediction[selectedIndex!]);
          } else {
            _showErrorDialog(context); // Alert if no item is selected
          }
        },
      ),
    );
  }

  void _showConfirmationDialog(String selectedItem) async {
    final docList = await getDoctorList();
    Get.dialog(AlertDialog(
      title: const Text("Selection Confirmed"),
      content: Obx(
        () => isLoading.value
            ? Container(
                width: 200,
                height: 200,
                child: const CircularProgressIndicator(),
              )
            : selectedIndex! > 2
                ? Text(
                    "You have selected $selectedItem. Proceed to book an appointment with a doctor?",
                    style: const TextStyle(fontSize: 16),
                  )
                : Text(
                    "You have selected $selectedItem. Do you want to auto book an appointment?",
                    style: const TextStyle(fontSize: 16),
                  ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            isLoading.value = true;
            if (selectedIndex == null) {
              return;
            }
            if (selectedIndex! > 2) {
              Get.offAndToNamed(AppRoutes.userAppointments);
              return;
            }
            final docList = await getDoctorList();
            Get.back();
            Get.bottomSheet(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BottomSheet(
                  onClosing: () {},
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: docList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(docList.values.elementAt(index)),
                            onTap: () {
                              _autoBook(docList.keys.elementAt(index));
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          },
          child: Text(selectedIndex! > 2 ? "Proceed" : "Auto Book"),
        ),
      ],
    ));
  }

  Future<void> _autoBook(String docId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    final url = Uri.parse("$kNodeApiUrl/api/v1/users/autoBookAppointment");
    final body = jsonEncode({
      "date": DateFormat('dd-MM-yyyy').format(DateTime.now()),
      "doctorId": docId,
    });
    print(body);
    final response = await http.post(url, headers: headers, body: body);
    isLoading.value = false;
    print(response.body);
    if (response.statusCode == 200) {
      Get.offAndToNamed(AppRoutes.userHome);
    } else {
      Get.snackbar("Error", "Failed to book appointment");
    }
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("No Selection"),
          content: const Text("Please select an item before confirming."),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
