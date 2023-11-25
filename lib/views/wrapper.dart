import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class WidgetWrapper extends ConsumerWidget {
  const WidgetWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStreamProvider).when(
      data: (user) {
        if (user == null) {
          return const LoginPage();
        }
        return ref.watch(driverStreamProvider).when(
          data: (driver) {
            if (!driver.isProfileComplete) {
              return const CompleteInfoPage();
            }
            return const ViewWrapper();
          },
          error: (error, stackTrace) {
            return const LoginErrorPage();
          },
          loading: () {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return const LoginErrorPage();
      },
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
