class UserInfoModel {
  String? uid;
  String? email;
  String? firstName;
  String? phoneNo;
  // String? imageURL;

  UserInfoModel({this.firstName, this.uid, this.email, this.phoneNo});

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      uid: map["uid"],
      email: map["email"],
      firstName: map["firstName"],
      phoneNo: map["phoneNo"],
      // imageURL: map["imageURL"],
    );
  }

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data["uid"] = uid;
    data["email"] = email;
    data["firstName"] = firstName;
    data["phoneNo"] = phoneNo;
    // data["imageURL"] = imageURL;
    return data;
  }
}
