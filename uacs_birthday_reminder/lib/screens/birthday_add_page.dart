import '../../components/birthday_card/birthday_card.dart';
import '../../components/date_picker.dart';
import '../../components/time_picker.dart';
import '../../components/view_title.dart';
import '../../utilities/birthday.dart';
import '../../utilities/birthday_data.dart';
import '../../utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddBirthdayPage extends StatefulWidget {
  final String name;
  final String notes;

  const AddBirthdayPage({
    Key? key,
    required this.name,
    required this.notes,
  }) : super(key: key);

  @override
  State<AddBirthdayPage> createState() => _AddBirthdayPageState();
}

class _AddBirthdayPageState extends State<AddBirthdayPage> {
  late String name;
  late String notes;
  

    @override
  void initState() {
    super.initState();
    name = widget.name;
    notes = notes;
  }

  DateTime date = DateTime.now();

  TimeOfDay time = TimeOfDay(
    hour: DateTime.now().hour,
    minute: DateTime.now().minute,
  );

  final ScrollController _scrollController = ScrollController();

  final _formKey = GlobalKey<FormState>();
  bool isNameInputCorrect = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blackPrimary,
      appBar: appBar(),
      body: RawScrollbar(
        thumbColor: Constants.lighterGrey,
        radius: const Radius.circular(20),
        thickness: 5,
        thumbVisibility: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ViewTitle('${AppLocalizations.of(context)!.editName}:'),
                inputNameField(),
                const SizedBox(height: 40),
                ViewTitle('${AppLocalizations.of(context)!.editDate}:'),
                datePicker(),
                const SizedBox(height: 40),
                ViewTitle('${AppLocalizations.of(context)!.editTime}:'),
                timePicker(),
                infoText(AppLocalizations.of(context)!.timeInfo),
                const SizedBox(height: 40),
                ViewTitle('${AppLocalizations.of(context)!.preview}:'),
                cardPreview(),
                const SizedBox(height: 40),
                saveButton(context),
                const SizedBox(height: 10),
                infoText(AppLocalizations.of(context)!.editInfo),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TimePicker timePicker() {
    return TimePicker(
      time,
      onTimeChanged: (newDateTime) {
        setState(() {
          time = newDateTime;
        });
      },
    );
  }

  DatePicker datePicker() {
    return DatePicker(
      date,
      onDayChanged: (newDayTime) {
        setState(() {
          date = newDayTime;
        });
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Constants.blackPrimary,
      iconTheme: IconThemeData(
        color: Constants.whiteSecondary,
      ),
      title: Text(
        AppLocalizations.of(context)!.birthdayAdd,
        style: const TextStyle(
          color: Constants.purpleSecondary,
          fontSize: Constants.titleFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: cancelButton(context),
    );
  }

  GestureDetector cancelButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(left: 15),
        child: const Icon(
          Icons.close,
          size: 25,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Container inputNameField() {
    return Container(
      decoration: const BoxDecoration(
        color: Constants.greySecondary,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              keyboardAppearance: Brightness.dark,
              style: const TextStyle(color: Constants.whiteSecondary),
              inputFormatters: [
                LengthLimitingTextInputFormatter(12),
              ],
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 3, color: Constants.purpleSecondary),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                fillColor: Constants.purpleSecondary,
                focusColor: Constants.purpleSecondary,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide.none,
                ),
                floatingLabelStyle: const TextStyle(
                  color: Constants.purpleSecondary,
                  fontSize: Constants.biggerFontSize,
                  fontWeight: FontWeight.bold,
                ),
                hintStyle: const TextStyle(
                  color: Constants.lighterGrey,
                  fontSize: 15,
                ),
                labelText: AppLocalizations.of(context)!.name,
                labelStyle: const TextStyle(
                  color: Constants.whiteSecondary,
                  fontSize: Constants.normalFontSize,
                ),
                errorStyle: const TextStyle(
                  fontSize: Constants.smallerFontSize,
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  name = value.toString();
                  if (_formKey.currentState!.validate()) {
                    isNameInputCorrect = true;
                  }
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.nameError;
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: notes,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 3, color: Constants.purpleSecondary),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                fillColor: Constants.purpleSecondary,
                focusColor: Constants.purpleSecondary,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide.none,
                ),
                floatingLabelStyle: const TextStyle(
                  color: Constants.purpleSecondary,
                  fontSize: Constants.biggerFontSize,
                  fontWeight: FontWeight.bold,
                ),
                labelText: AppLocalizations.of(context)!.note,
                labelStyle: const TextStyle(
                  color: Constants.whiteSecondary,
                  fontSize: Constants.normalFontSize,
                ),
                errorStyle: const TextStyle(
                  fontSize: Constants.smallerFontSize,
                ),
              ),
              onChanged: (String value) {
                setState(() {
                  notes = value;
                });
              },
              validator: (String? value) {
                return null;
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Container cardPreview() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: BirthdayCard(Birthday(name, date), false),
    );
  }

  Container saveButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isNameInputCorrect ? Constants.purpleSecondary : Colors.red,
        ),
        child: Text(
          AppLocalizations.of(context)!.save,
          style: const TextStyle(
              color: Constants.whiteSecondary,
              fontSize: Constants.normalFontSize,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          saveBirthday(context);
        },
      ),
    );
  }

  void saveBirthday(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        isNameInputCorrect = false;
      });
      return;
    }

    DateTime birthdayWithTime = DateTime(
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
    );

    addBirthday(Birthday(name, birthdayWithTime)).then(
      (value) => Navigator.pushReplacementNamed(context, '/').then(
        (value) => setState(
          () {},
        ),
      ),
    );
  }

  Row infoText(String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 30, right: 30),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Constants.darkerGrey,
                  fontSize: Constants.normalFontSize,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
