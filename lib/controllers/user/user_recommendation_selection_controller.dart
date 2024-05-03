import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:aetherwell/models/predictions.dart';
import 'package:aetherwell/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:http/http.dart' as http;

class UserRecommendationSelectionController extends GetxController {
  var selectedItems = <String>[].obs;
  var currentTip = ''.obs;

}