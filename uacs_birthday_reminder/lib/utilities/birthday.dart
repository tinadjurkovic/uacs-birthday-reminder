import '../../utilities/birthday_data.dart';

class Birthday {
  late int _birthdayId;
  late String _name;
  late String _notes;
  late DateTime _date;
  late List<int> _notificationIds;
  late bool _allowNotifications;
  late int? _birthdayGroupId;

  String get notes {
    return _notes;
  }

  set notes(String notes) {
    _notes = notes;
  }

  int get birthdayId {
    return _birthdayId;
  }

  set setbirthdayId(int birthdayId) {
    _birthdayId = birthdayId;
  }

  String get name {
    return _name;
  }

  set setname(String name) {
    _name = name;
  }

  DateTime get date {
    return _date;
  }

  set setdate(DateTime birthdayDate) {
    _date = birthdayDate;
  }

  List<int> get notificationIds {
    return _notificationIds;
  }

  set setnotificationIds(List<int> newNotificationIds) {
    _notificationIds = newNotificationIds;
  }

  int? get birthdayGroupId {
    return _birthdayGroupId;
  }

  set setbirthdayGroupId(int? birthdayGroupId) {
    _birthdayGroupId = birthdayGroupId;
  }

  bool get allowNotifications {
    return _allowNotifications;
  }

  set setAllowNotifications(bool value) {
    _allowNotifications = value;
  }

  Birthday(
    this._name,
    this._date, [
    int? id,
    List<int>? notificationIds,
    bool? allowNotifications,
    this._birthdayGroupId,
    String? notes,
  ]) {
    _birthdayId = id ?? getNewBirthdayId();
    _notes = notes ?? '';
    List<int>? newNotificationIds = [
      int.parse("${birthdayId}1"),
      int.parse("${birthdayId}2"),
      int.parse("${birthdayId}3"),
      int.parse("${birthdayId}4"),
    ];
    _notificationIds = notificationIds ?? newNotificationIds;
    _allowNotifications = allowNotifications ?? true;
  }

  factory Birthday.fromJson(Map<String, dynamic> json) {
    return Birthday(
      json['name'] as String,
      DateTime.parse(json['date'] as String),
      json['id'] as int,
      json['notificationIds'] != null
          ? List<int>.from(json['notificationIds'] as List<dynamic>)
          : null,
      json['allowNotifications'] as bool,
      json['birthdayGroupId'] as int?,
      json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _birthdayId,
      'date': _date.toIso8601String(),
      'name': _name,
      'note': _notes,
      'allowNotifications': _allowNotifications,
      'notificationIds': _notificationIds,
      'birthdayGroupId': _birthdayGroupId,
    };
  }
}
