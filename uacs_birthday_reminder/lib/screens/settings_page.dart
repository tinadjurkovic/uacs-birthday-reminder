import 'package:awesome_notifications/awesome_notifications.dart';
import '../../components/view_title.dart';
import '../../screens/about_page.dart';
import '../../utilities/constants.dart';
import '../../utilities/notification_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blackPrimary,
      appBar: appBar(),
      body: body(),
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Constants.blackPrimary,
      iconTheme: IconThemeData(
        color: Constants.whiteSecondary,
      ),
      title: Text(
        AppLocalizations.of(context)!.settings,
        style: const TextStyle(
          color: Constants.purpleSecondary,
          fontSize: Constants.titleFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        infoButton(context),
      ],
      leading: backButton(context),
    );
  }

  GestureDetector backButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(left: 15),
        child: const Icon(
          Icons.arrow_back,
          size: 30,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  GestureDetector infoButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        child: const Icon(
          Icons.info_outline,
          size: 30,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) {
            return const AboutPage();
          },
        ));
      },
    );
  }

  Widget body() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          ViewTitle(AppLocalizations.of(context)!.notifications),
          activateNotificationBanner(),
          Container(
            margin: const EdgeInsets.only(right: 50, left: 50, bottom: 30),
            child: Column(
              children: [
                notificationOneDayBefore(),
                notificationOneWeekBefore(),
                notificationOneMonthBefore(),
              ],
            ),
          ),
          ViewTitle(AppLocalizations.of(context)!.notificationTime),
          Container(
            margin: const EdgeInsets.only(right: 50, left: 50, bottom: 30),
            child: Column(
              children: [
                notificationsTimeSetting(),
              ],
            ),
          ),
          ViewTitle(AppLocalizations.of(context)!.exportImport),
          //TODO Group3: Export/Import JSON file
        ],
      ),
    );
  }

  FutureBuilder<bool> activateNotificationBanner() {
    return FutureBuilder(
      future: AwesomeNotifications().isNotificationAllowed(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (!(snapshot.data as bool)) {
            return infoText();
          }
        }
        return Container();
      },
    );
  }

  Widget infoText() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Constants.darkGreySecondary,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)!.allowNotifications,
                  //'test',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Constants.lighterGrey,
                    fontSize: Constants.smallerFontSize + 2,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: (() {
                    requestNotificationAccess(context);
                  }),
                  child: Text(
                    AppLocalizations.of(context)!.activate,
                    style: const TextStyle(
                      fontSize: Constants.smallerFontSize + 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row notificationsTimeSetting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.timeForNotification,
          style: const TextStyle(
            color: Constants.whiteSecondary,
            fontSize: Constants.normalFontSize,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 70,
          height: 55,
          child: FittedBox(
            fit: BoxFit.fill,
            // TODO Group3: Implement TimePicker
          ),
        ),
      ],
    );
  }

  Row notificationOneDayBefore() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.oneDayBefore,
          style: const TextStyle(
            color: Constants.whiteSecondary,
            fontSize: Constants.normalFontSize,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 70,
          height: 55,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Switch(
              value: notiOneDayBefore,
              onChanged: (value) {
                setState(() {
                  setNotificationOneDayBefore(value);
                });
              },
              inactiveThumbColor: Constants.lighterGrey,
              inactiveTrackColor: Constants.darkGreySecondary,
            ),
          ),
        ),
      ],
    );
  }

  Row notificationOneWeekBefore() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.oneWeekBefore,
          style: const TextStyle(
            color: Constants.whiteSecondary,
            fontSize: Constants.normalFontSize,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 70,
          height: 55,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Switch(
              value: notiOneWeekBefore,
              onChanged: (value) {
                setState(() {
                  setNotificationOneWeekBefore(value);
                });
              },
              inactiveThumbColor: Constants.lighterGrey,
              inactiveTrackColor: Constants.darkGreySecondary,
            ),
          ),
        ),
      ],
    );
  }

  Row notificationOneMonthBefore() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.oneMonthBefore,
          style: const TextStyle(
            color: Constants.whiteSecondary,
            fontSize: Constants.normalFontSize,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 70,
          height: 55,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Switch(
              value: notiOneMonthBefore,
              onChanged: (value) {
                setState(() {
                  setNotificationOneMonthBefore(value);
                });
              },
              inactiveThumbColor: Constants.lighterGrey,
              inactiveTrackColor: Constants.darkGreySecondary,
            ),
          ),
        ),
      ],
    );
  }
}