import 'package:contacts_buddy/contacts_app.dart';
import 'package:contacts_buddy/models/contact.dart';
import 'package:contacts_buddy/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await initHive();

  // run the app
  runApp(const ContactsApp());
}
