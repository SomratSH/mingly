import 'package:flutter/widgets.dart';
import 'package:mingly/src/application/notification/model/notification_model.dart';
import 'package:mingly/src/application/notification/repo/notification_repo.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationModel notificationModel = NotificationModel();
  bool isLoading = false;
  Future<void> getNotificationData() async {
    isLoading = true;
    notifyListeners();
    final reseponse = await NotificationRepo().getNotifcation();
    if (reseponse != null) {
      notificationModel = reseponse;
      isLoading = false;
      notifyListeners();
    }
  }
}
