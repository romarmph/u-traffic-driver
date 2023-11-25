import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';

class AppDrawerHeader extends ConsumerWidget {
  const AppDrawerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDriver = ref.watch(driverAccountProvider);

    return Container(
      height: 120,
      decoration: const BoxDecoration(
        color: UColors.blue700,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: USpace.space20),
          Row(
            children: [
              const SizedBox(width: USpace.space20),
              currentDriver!.photoUrl.isEmpty
                  ? const CircleAvatar(
                      radius: 24,
                      backgroundColor: UColors.gray50,
                      child: Icon(
                        Icons.person,
                        size: 24,
                        color: UColors.gray200,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: currentDriver.photoUrl,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 24,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) => const CircleAvatar(
                        radius: 24,
                        backgroundColor: UColors.gray50,
                        child: Icon(Icons.person),
                      ),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        radius: 24,
                        backgroundColor: UColors.gray50,
                        child: Icon(
                          Icons.person,
                          size: 48,
                          color: UColors.gray200,
                        ),
                      ),
                    ),
              const SizedBox(width: 10),
              Expanded(
                child: ListTile(
                  title: Text(
                    "${currentDriver.firstName} ${currentDriver.lastName}",
                    style: const UTextStyle().textlgfontbold.copyWith(
                          color: UColors.white,
                        ),
                  ),
                  subtitle: Text(
                    currentDriver.email,
                    style: const UTextStyle().textsmfontnormal.copyWith(
                          color: UColors.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
