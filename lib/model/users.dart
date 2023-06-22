class UserData {
  String? name;
  String? password;
  String? email;
  String? createdOn;
  String? uid;
  
  UserData({this.name, this.password, this.email, this.createdOn, this.uid});

  //Create a From Json Function
  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    password = json['password'];
    email = json['email'];
    createdOn = json['createdOn'];
    uid = json['uid'];
  }
}
