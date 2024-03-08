import 'package:flutter/material.dart';
import '../base/modules/navigation/navigation_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButton;
  final Function()? onTap;
  const CustomAppBar({super.key, this.onTap, this.isBackButton = true, this.title});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(title ?? ''),
      leading: isBackButton
          ? IconButton(
              onPressed: () {
                NavigationService.instance.navigatePop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_sharp))
          : const SizedBox(),
    );
  }
}
