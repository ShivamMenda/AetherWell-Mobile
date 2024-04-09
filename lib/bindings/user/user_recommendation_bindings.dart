import 'package:aetherwell/controllers/user/user_recomendation_controller.dart';
import 'package:get/get.dart';

class UserRecommendationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserRecommendationController>(UserRecommendationController());
  }
}
