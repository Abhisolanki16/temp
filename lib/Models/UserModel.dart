class UserModel {
  String? uid;
  String? username;
  String? email;
  String? profilepic;

  UserModel({this.uid, this.username, this.email, this.profilepic});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    username = map["fullname"];
    email = map["email"];
    profilepic = map["profilepic"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": username,
      "email": email,
      "profilepic": profilepic,
    };
  }
}