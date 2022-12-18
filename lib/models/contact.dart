import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 1)
class Contact extends HiveObject {
  @HiveField(0)
  String? firstName;
  @HiveField(1)
  String? secondName;
  @HiveField(2)
  String? nikName;
  @HiveField(3)
  String? mobileNumber;
  @HiveField(4)
  String? landNumber;
  @HiveField(5)
  String? emailAddress;
  @HiveField(6)
  String? image;

  Contact(
      {this.firstName,
      this.secondName,
      this.nikName,
      this.mobileNumber,
      this.landNumber,
      this.emailAddress,
      this.image});

  Contact.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    secondName = json['second_name'];
    nikName = json['nik_name'];
    mobileNumber = json['mobile_number'];
    landNumber = json['land_number'];
    emailAddress = json['email_address'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['second_name'] = this.secondName;
    data['nik_name'] = this.nikName;
    data['mobile_number'] = this.mobileNumber;
    data['land_number'] = this.landNumber;
    data['email_address'] = this.emailAddress;
    data['image'] = this.image;
    return data;
  }
}
