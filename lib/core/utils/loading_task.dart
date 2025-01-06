import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingTask {
 loadingDialog(bool isLoading) {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.pulse
      ..userInteractions = false
      ..loadingStyle = EasyLoadingStyle.dark
      ..maskType = EasyLoadingMaskType.black;
    return isLoading
        ? EasyLoading.show(dismissOnTap: false)
        : EasyLoading.dismiss();
  }
}
LoadingTask loadingTask = LoadingTask();