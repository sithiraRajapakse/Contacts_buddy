import 'package:contacts_buddy/models/contact.dart';
import 'package:contacts_buddy/pages/add_page.dart';
import 'package:contacts_buddy/pages/details_page.dart';
import 'package:contacts_buddy/services/database.dart';
import 'package:contacts_buddy/widgets/contact_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'D',
  ];
  final List<int> colorCodes = <int>[
    100,
    200,
    300,
    400,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'images/telephone.png',
                        width: 48.0,
                        height: 48.0,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Text(
                        'Contacts Buddy',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 32.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.teal,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                        icon: const Icon(Icons.add),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const AddPage();
                            },
                          ));
                          // show add contacts page
                        }),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border.all(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: Colors.black26,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: SearchField(
                      width: (MediaQuery.of(context).size.width / 100) * 70,
                      onPressed: () {},
                      hintText: 'Enter search words here...',
                      iconColor: Colors.white70,
                      searchIcon: const Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.grid_3x3_outlined),
                  //   color: Colors.blueGrey,
                  // ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<Contact>(contactsBoxName).listenable(),
                  builder: (context, Box<Contact> box, _) {
                    if (box.values.isEmpty) {
                      return const Center(
                        child: Text("No contacts available."),
                      );
                    }

                    return ListView.separated(
                        itemBuilder: (context, index) {
                          Contact? contact = box.getAt(index);
                          return ContactListTile(contact: contact!);
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 1.0,
                          );
                        },
                        itemCount: box.values.length);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
