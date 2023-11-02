import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/shared/utils/app_color.dart';

import '../../utils/strings.dart';

class RequestSignInDialog extends StatelessWidget {
  const RequestSignInDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: AppColor.transparentColor,
      content: Container(
        width: baseWidth - 2 * 16,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: AppColor.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12.0),
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 56.0,
            ),
            const SizedBox(height: 12.0),
            const Text(
              Strings.titleNotifyNotSignIn,
              style: TextStyle(
                fontSize: 18.0,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                Strings.subtitleNotifyNotSignIn,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 48.0,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: MaterialButton(
                onPressed: () {
                  context.goNamed('signIn');
                },
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                elevation: 0.0,
                color: AppColor.primaryAppColor,
                child: const Text(
                  Strings.titleSignInButton,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 48.0,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: MaterialButton(
                onPressed: () {
                  context.pop();
                },
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                elevation: 0.0,
                color: AppColor.cancelButtonColor,
                child: const Text(
                  Strings.titleCancelSignIn,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
