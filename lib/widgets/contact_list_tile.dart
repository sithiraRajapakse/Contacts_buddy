import 'dart:io';

import 'package:contacts_buddy/models/contact.dart';
import 'package:contacts_buddy/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactListTile extends StatelessWidget {
  final Contact contact;

  const ContactListTile({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          decoration: const BoxDecoration(
            color: Colors.white38,
            // border: Border.all(
            //   width: 1.0,
            //   color: Colors.grey.shade200,
            // ),
          ),
          //padding: const EdgeInsets.only(left: 6.0),
          height: 50,
          child: Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  backgroundImage: FileImage(
                    File(contact.image!),
                  ),
                ),
              ),
              // Image.asset(
              //   'images/man.png',
              //   height: 32.0,
              //   width: 32.0,
              // ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${contact.firstName!} ${contact.secondName!}',
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            contact.mobileNumber!,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: IconButton(
                        onPressed: () async {
                          final Uri telephoneLaunchUri =
                              Uri(scheme: 'tel', path: contact.mobileNumber!);
                          launchUrl(telephoneLaunchUri);
                        },
                        icon: Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return DetailsPage(contact: contact);
          },
        ));
      },
    );
  }
}
