import 'package:danastoreadminpanel/features/authentication/controllers/user_controller.dart';
import 'package:danastoreadminpanel/utils/constants/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBinding extends Bindings{
  @override 
  void dependencies() {
    /// --Core
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
  }
}