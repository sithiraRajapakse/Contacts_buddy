import 'dart:io';

import 'package:contacts_buddy/models/contact.dart';
import 'package:contacts_buddy/pages/home_page.dart';
import 'package:contacts_buddy/services/database.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key, required this.contact}) : super(key: key);
  final Contact contact;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  // init controllers for form fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _nikNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _landNumberController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();

  // init image picker instance
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _pickedImage;

  /// save the contact
  Future<void> updateContact() async {
    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      widget.contact.firstName = _firstNameController.text;
      widget.contact.secondName = _secondNameController.text;
      widget.contact.nikName = _nikNameController.text;
      widget.contact.mobileNumber = _mobileNumberController.text;
      widget.contact.landNumber = _landNumberController.text;
      widget.contact.emailAddress = _emailAddressController.text;

      // save and move image if image is selected
      if (_pickedImage != null) {
        // move image to path
        Directory documentsDirectory = await getApplicationDocumentsDirectory();

        // save image to app documents directory
        _pickedImage!.saveTo(documentsDirectory.path);

        // set image path in contact object
        widget.contact.image = _pickedImage!.path;
      }

      await widget.contact.save();

      if (!mounted) return;

      // clear showing snackbars, if any
      ScaffoldMessenger.of(context).clearSnackBars();

      // show success dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Contact details updated successfully.'),
            icon: const Icon(Icons.check, size: 48.0),
            iconColor: Colors.green,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomePage();
                      },
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _firstNameController.text = widget.contact.firstName!;
    _secondNameController.text = widget.contact.secondName!;
    _nikNameController.text = widget.contact.nikName!;
    _mobileNumberController.text = widget.contact.mobileNumber!;
    _landNumberController.text = widget.contact.landNumber!;
    _emailAddressController.text = widget.contact.emailAddress!;
    _pickedImage = XFile(widget.contact.image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Contact'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Confirm Deletion'),
                    content: const Text('Are you sure you want to delete?'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await widget.contact.delete();

                          if (!mounted) return;

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return const HomePage();
                              },
                            ),
                          );
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _getPickedImage(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        // Pick an image
                        XFile? image = await _imagePicker.pickImage(
                          source: ImageSource.camera,
                        );
                        setState(() {
                          _pickedImage = image;
                        });
                      },
                      icon: const Icon(Icons.camera_alt),
                    ),
                    IconButton(
                      onPressed: () async {
                        // Pick an image
                        XFile? image = await _imagePicker.pickImage(
                          source: ImageSource.gallery,
                        );
                        setState(() {
                          _pickedImage = image;
                        });
                      },
                      icon: const Icon(Icons.browse_gallery),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.black,
                    ),
                    labelText: 'First Name',
                    hintText: 'Ex: Sithira',
                  ),
                  keyboardType: TextInputType.name,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _secondNameController,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.black,
                    ),
                    labelText: 'Second Name',
                    hintText: 'Ex: Rajapaksha',
                  ),
                  keyboardType: TextInputType.name,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nikNameController,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.black,
                    ),
                    labelText: 'Nik Name',
                    hintText: 'Ex: Brother',
                    helperText:
                        'Hint: Add something short you can use remember this contact',
                  ),
                  keyboardType: TextInputType.name,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _mobileNumberController,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.phone_android,
                      color: Colors.black,
                    ),
                    labelText: 'Mobile Phone Number',
                    hintText: 'Ex: +94 71 6821 573',
                  ),
                  keyboardType: TextInputType.phone,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _landNumberController,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.phone_in_talk,
                      color: Colors.black,
                    ),
                    labelText: 'Land Phone Number',
                    hintText: 'Ex: +94 34 6821 573',
                  ),
                  keyboardType: TextInputType.phone,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailAddressController,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    labelText: 'Email',
                    hintText: 'Ex: samplemail.lk',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200.0, 48.0),
                    backgroundColor: Colors.teal,
                  ),
                  onPressed: () async {
                    updateContact();
                  },
                  child: const Text(
                    'Update Contact',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // returns the image with picked image set or default set
  CircleAvatar _getPickedImage() {
    if (_pickedImage != null) {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        backgroundImage: FileImage(
          File(_pickedImage!.path),
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
