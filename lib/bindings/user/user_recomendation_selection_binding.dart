import 'package:aetherwell/controllers/user/user_recomendation_controller.dart';
import 'package:aetherwell/controllers/user/user_recommendation_selection_controller.dart';
import 'package:aetherwell/views/screens/user/user_recommendation_selection.dart';
import 'package:get/get.dart';

class UserRecommendationSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserRecommendationSelectionController>(UserRecommendationSelectionController());
  }
}