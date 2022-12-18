import 'dart:io';

import 'package:contacts_buddy/models/contact.dart';
import 'package:contacts_buddy/pages/edit_page.dart';
import 'package:contacts_buddy/widgets/contact_detail_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_page.dart';

class DetailsPage extends StatelessWidget {
  final Contact contact;

  const DetailsPage({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Contact'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 32.0,
              ),
              _getContactImage(),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    Text(
                      '${contact.firstName!} ${contact.secondName!}',
                      style: TextStyle(fontSize: 32.0),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    ContactDetailRow(
                      label: 'First Name',
                      content: (contact.firstName!),
                    ),
                    const Divider(
                      height: 32.0,
                      thickness: 2.0,
                    ),
                    ContactDetailRow(
                      label: 'Second Name',
                      content: (contact.secondName!),
                    ),
                    const Divider(
                      height: 32.0,
                      thickness: 2.0,
                    ),
                    ContactDetailRow(
                      label: 'Nickname',
                      content: (contact.nikName!),
                    ),
                    const Divider(
                      height: 32.0,
                      thickness: 2.0,
                    ),
                    ContactDetailRow(
                      label: 'Mobile Phone',
                      content: (contact.mobileNumber!),
                    ),
                    const Divider(
                      height: 32.0,
                      thickness: 2.0,
                    ),
                    ContactDetailRow(
                      label: 'Land Phone',
                      content: (contact.landNumber!),
                    ),
                    const Divider(
                      height: 32.0,
                      thickness: 2.0,
                    ),
                    ContactDetailRow(
                      label: 'Email',
                      content: (contact.emailAddress!),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200.0, 48.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return EditPage(
                                contact: contact,
                              );
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Edit Contact',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // returns the image with picked image set or default set
  CircleAvatar _getContactImage() {
    if (contact.image != null) {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        backgroundImage: FileImage(
          File(contact.image!),
        ),
      );
    }

    return const CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        backgroundImage: AssetImage(
          'images/man.png',
        ));
  }
}
