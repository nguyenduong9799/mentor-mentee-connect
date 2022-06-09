import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'Service/push_notification_service.dart';
import 'firebase_options.dart';

Future setUp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // PushNotificationService? ps = PushNotificationService.getInstance();
  // await ps!.init();
}

void createRouteBindings() async {
  // Get.put(RootViewModel());
  // Get.put(HomeViewModel());
  // Get.put(AccountViewModel());
  // Get.put(OrderHistoryViewModel());
  // Get.put(ProductFilterViewModel());
  // Get.put(TransactionViewModel());
  // Get.put(BlogsViewModel());
  // Get.put(GiftViewModel());
  // Get.put(OrderViewModel());
}
