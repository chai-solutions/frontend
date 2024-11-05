import 'package:chai/repository/user.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onesignal.g.dart';

@riverpod
OneSignalService oneSignalService(OneSignalServiceRef ref) {
  final user = ref.watch(currentUserProvider);

  final userID = user.maybeWhen(
    // TODO: this must be changed to the UUID once it is present
    data: (u) => u.id.toString(),
    orElse: () => null,
  );

  return OneSignalService(
    userID,
  );
}

enum OnesignalAuthStatus { loggedIn, loggedOut }

class OneSignalService {
  final String? userID;
  OnesignalAuthStatus status = OnesignalAuthStatus.loggedOut;

  OneSignalService(this.userID);

  Future<void> login() async {
    await OneSignal.login(userID!);
    status = OnesignalAuthStatus.loggedIn;
  }

  Future<void> logout() async {
    await OneSignal.logout();
    status = OnesignalAuthStatus.loggedOut;
  }

  Future<bool> requestPermission() async {
    if (OneSignal.Notifications.permission) {
      return true;
    }

    final resp = await OneSignal.Notifications.requestPermission(false);
    return resp;
  }
}

@riverpod
void oneSignalListener(OneSignalListenerRef ref) {
  ref.listen(oneSignalServiceProvider, (_, service) async {
    if (service.userID != null &&
        service.status == OnesignalAuthStatus.loggedOut) {
      print("logging in with user ${service.userID}");
      service.login();
      print("logged into onesignal");
    } else if (service.userID != null &&
        service.status == OnesignalAuthStatus.loggedIn) {
      print("logging out with user ${service.userID}");
      service.logout();
    }
  });
}
