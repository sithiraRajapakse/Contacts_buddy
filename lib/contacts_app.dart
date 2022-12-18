import 'package:contacts_buddy/pages/home_page.dart';
import 'package:flutter/material.dart';

class ContactsApp extends StatelessWidget {
  const ContactsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts Buddy',
      home: HomePage(),
    );
  }
}
