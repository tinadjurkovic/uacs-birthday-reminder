import 'package:uacs_birthday_reminder/utilities/birthday.dart';

import '../../components/precise_age.dart';
import '../../components/view_title.dart';
import 'package:confetti/confetti.dart';
import '../../components/birthday_timer/birthday_timer.dart';
import '../../components/wish_generator.dart';
import '../../screens/birthday_edit_page.dart';
import '../../utilities/birthday_data.dart';
import '../../utilities/calculator.dart';
import '../../utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BirthdayInfoPage extends StatefulWidget {
  final int birthdayId;

  const BirthdayInfoPage(this.birthdayId, {Key? key}) : super(key: key);

  @override
  State<BirthdayInfoPage> createState() => _BirthdayInfoPageState();
}

class _BirthdayInfoPageState extends State<BirthdayInfoPage> {
  late ConfettiController confetti;

  @override
  void initState() {
    super.initState();
    confetti = ConfettiController(duration: const Duration(seconds: 10));
    Calculator.hasBirthdayToday(getDataById(widget.birthdayId).date)
        ? confetti.play()
        : null;
  }

  @override
  void dispose() {
    confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blackPrimary,
      appBar: appBar(context),
      body: body(context),
    );
  }

  SingleChildScrollView body(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            confettiSpawner(),
            const SizedBox(height: 30),
            informationSection(),
            const SizedBox(height: 40),
            ViewTitle(AppLocalizations.of(context)!.preciseAge),
            const SizedBox(height: 20),
            PreciseAge(getDataById(widget.birthdayId).date),
            const SizedBox(height: 40),
            ViewTitle(AppLocalizations.of(context)!.countdown),
            const SizedBox(height: 20),
            BirthdayTimer(widget.birthdayId),
            const SizedBox(height: 40),
            ViewTitle(AppLocalizations.of(context)!.generateWish),
            WishGenerator(getDataById(widget.birthdayId)),
            const SizedBox(height: 10),
            allowNotificationSwitch(),
            Container(height: 30),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Constants.blackPrimary,
      iconTheme: IconThemeData(
        color: Constants.whiteSecondary,
      ),
      title: Center(
        child: Text(
          AppLocalizations.of(context)!.birthdayInfo,
          style: const TextStyle(
            color: Constants.purpleSecondary,
            fontSize: Constants.titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Container(
            margin: const EdgeInsets.only(right: 15),
            child: const Icon(
              Icons.edit,
              size: 25,
            ),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return BirthdayEditPage(widget.birthdayId);
            })).then((value) => setState(() {}));
          },
        ),
      ],
    );
  }

  ConfettiWidget confettiSpawner() {
    return ConfettiWidget(
      confettiController: confetti,
      blastDirectionality: BlastDirectionality.explosive,
      colors: const [
        Colors.green,
        Colors.blue,
        Colors.pink,
        Colors.orange,
        Colors.purple
      ],
      emissionFrequency: 0.05,
    );
  }

Widget informationSection() {
  Birthday birthday = getDataById(widget.birthdayId);
  int weekdayNumber = birthday.date.weekday;
  String weekday = Calculator.getDayName(weekdayNumber, context);

  int day = birthday.date.day;

  int monthNumber = birthday.date.month;
  String month = Calculator.getMonthName(monthNumber, context);

  int year = birthday.date.year;

  int hourNumber = birthday.date.hour;
  int minuteNumber = birthday.date.minute;

  String hour = hourNumber < 10 ? '0$hourNumber' : '$hourNumber';
  String minute = minuteNumber < 10 ? '0$minuteNumber' : '$minuteNumber';

  return Column(
    children: [
      const SizedBox(height: 10),
      const Icon(
        Icons.cake_outlined,
        size: 80,
        color: Constants.whiteSecondary,
      ),
      const SizedBox(height: 10),
      Text(
        birthday.name,
        style: const TextStyle(
          color: Constants.whiteSecondary,
          fontSize: Constants.titleFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10),
      Text(
        '$weekday, $day. $month $year - $hour:$minute',
        style: const TextStyle(
          color: Constants.whiteSecondary,
          fontSize: Constants.normalFontSize,
        ),
      ),
      const SizedBox(height: 10),
      zodiacSign(),
           const SizedBox(height: 10),
        Text(
          'Notes: ${birthday.notes}', 
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
            return BirthdayEditPage(widget.birthdayId);
          })).then((value) => setState(() {}));
        },
        child: Text('Edit'),
      ),
    ],
  );
}


  Row zodiacSign() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Text(
            Calculator.getZodiacSign(
              getDataById(widget.birthdayId).date,
              context,
            )[1],
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Constants.whiteSecondary,
              fontSize: 30,
            ),
          ),
        ),
        Text(
          Calculator.getZodiacSign(
            getDataById(widget.birthdayId).date,
            context,
          )[0],
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Constants.whiteSecondary,
            fontSize: Constants.normalFontSize,
          ),
        ),
      ],
    );
  }

  Padding allowNotificationSwitch() {
    return Padding(
      padding: const EdgeInsets.only(right: 35.0, left: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.allowNotification,
            style: const TextStyle(
              color: Constants.whiteSecondary,
              fontSize: Constants.smallerFontSize,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 70,
            height: 55,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Switch(
                value: getDataById(widget.birthdayId).allowNotifications,
                onChanged: (value) {
                  setState(() {
                    var birth = getDataById(widget.birthdayId);
                    birth.setAllowNotifications = value;
                  });
                },
                inactiveThumbColor: Constants.lighterGrey,
                inactiveTrackColor: Constants.darkGreySecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
