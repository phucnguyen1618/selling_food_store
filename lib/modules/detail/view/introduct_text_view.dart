import 'package:flutter/material.dart';
import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/strings.dart';

class IntroduceTextView extends StatefulWidget {
  final String? content;
  const IntroduceTextView({
    super.key,
    required this.content,
  });

  @override
  State<IntroduceTextView> createState() => _IntroduceTextViewState();
}

class _IntroduceTextViewState extends State<IntroduceTextView> {
  bool isExpend = false;

  @override
  Widget build(BuildContext context) {
    return widget.content == null
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                Strings.descBrandEmpty,
                style: TextStyle(
                  fontSize: 14.0,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AnimatedCrossFade(
                    firstChild: Text(
                      widget.content!,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 14.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    secondChild: Text(
                      widget.content!,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    crossFadeState: isExpend
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: kThemeAnimationDuration),
                const SizedBox(height: 4.0),
                InkWell(
                  onTap: () {
                    setState(() {
                      isExpend = !isExpend;
                    });
                  },
                  child: Text(
                    isExpend ? Strings.showLess : Strings.viewMore,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
