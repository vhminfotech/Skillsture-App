import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dialog_utils.dart';
import 'localization/localization.dart';

class PermissionUtils {
  static void requestPermission(
      List<PermissionGroup> permission, BuildContext context,
      {Function permissionGrant,
      Function permissionDenied,
      Function permissionNotAskAgain,
      bool isOpenSettings = false,
      bool isShowMessage = true}) {
    PermissionHandler().requestPermissions(permission).then((statuses) {
      var allPermissionGranted = true;

      statuses.forEach((key, value) {
        if (value == PermissionStatus.granted) {
          allPermissionGranted = allPermissionGranted && true;
        } else {
          allPermissionGranted = allPermissionGranted && false;
        }
      });

      if (allPermissionGranted) {
        if (permissionGrant != null) {
          permissionGrant();
        }
      } else {
        if (permissionDenied != null) {
          permissionDenied();
        }
        if (isOpenSettings) {
          DialogUtils.showOkCancelAlertDialog(
            context: context,
            message: Localization.of(context).alertPermissionNotRestricted,
            cancelButtonTitle: Localization.of(context).cancel,
            okButtonTitle: Localization.of(context).ok,
            okButtonAction: (){},
          );
        } else if (isShowMessage) {
          DialogUtils.displayToast(
              Localization.of(context).alertPermissionNotRestricted);
        }
      }
    });
  }

  static void checkPermissionStatus(
      PermissionGroup permission, BuildContext context,
      {Function permissionGrant, Function permissionDenied}) {
    PermissionHandler().checkPermissionStatus(permission).then((value) {
      if (value == PermissionStatus.granted) {
        permissionGrant();
      } else {
        permissionDenied();
      }
    });
  }
}





//USING EXAMPLE :
// PermissionUtils.requestPermission(
// [PermissionGroup.contacts, PermissionGroup.location],
// context,
// isOpenSettings: true,
// permissionGrant: () {},
// permissionDenied: () {},
// );
