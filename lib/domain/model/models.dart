class UserObject {
  String? fullName;
  String? phoneNumber;
  String? uid;

  UserObject(this.fullName, this.phoneNumber, this.uid);

  UserObject.fromJson(Map<String, dynamic> json) {
    fullName = json["fullName"];
    phoneNumber = json["phoneNumber"];
    uid = json["uid"];
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'uid': uid,
    };
  }
}
