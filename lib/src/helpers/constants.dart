import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/custom_button.dart';

MaterialColor appPrimaryColor = MaterialColor(
  0xFFA033FF,
  const <int, Color>{
    50: const Color(0xFFA033FF),
    100: const Color(0xFFA033FF),
    200: const Color(0xFFA033FF),
    300: const Color(0xFFA033FF),
    400: const Color(0xFFA033FF),
    500: const Color(0xFFA033FF),
    600: const Color(0xFFA033FF),
    700: const Color(0xFFA033FF),
    800: const Color(0xFFA033FF),
    900: const Color(0xFFA033FF),
  },
);
String appName = "";
Color hintColor = Color(0xFFA0A2A8);
Color buttonColor = Color(0xFFF13B2D);

void showOptionsBottomSheet({
  required BuildContext context,
  required Text title,
  required List<ListTile> options,
  required ValueChanged<int> onItemSelected,
  bool? showSkipButton,
  String? skipButtonText,
  VoidCallback? onSkipPressed,
}) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10),
                  child: Align(
                      alignment: Alignment.centerLeft, child: title),
                ),
                Container(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    removeBottom: true,
                    context: context,
                    child: ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: options.map((e) {
                        int index = options.indexOf(e);
                        return InkWell(
                            onTap: () {
                              onItemSelected(index);

                              print(index);
                            },
                            child: e);
                      }).toList(),
                    ),
                  ),
                ),
                Visibility(
                  visible: showSkipButton ?? false,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomButton(
                        text: skipButtonText ?? "Cancel",
                        onPressed: onSkipPressed ??
                                () {
                              Navigator.of(context).pop();
                            }),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
    ) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}


Future<DateTime> selectDate(BuildContext context, int startTimestamp,
    int? selectedTimestamp) async {
  DateTime selectedDate = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.fromMillisecondsSinceEpoch(
          selectedTimestamp ?? startTimestamp),
      firstDate: DateTime.fromMillisecondsSinceEpoch(startTimestamp),
      lastDate: DateTime(2101));
  if (picked != null && picked != selectedDate) selectedDate = picked;

  return selectedDate;
}


String timestampToDateFormat(int timestamp, String format) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat(format).format(dateTime);
}

