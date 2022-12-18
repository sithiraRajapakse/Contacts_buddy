import 'package:contacts_buddy/models/contact.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String contactsBoxName = 'contacts';

Future<void> initHive() async {
  // initialize database
  await Hive.initFlutter();

  // register contact adapter class
  Hive.registerAdapter(ContactAdapter());

  // open a box for contacts
  await Hive.openBox<Contact>(contactsBoxName);
}
