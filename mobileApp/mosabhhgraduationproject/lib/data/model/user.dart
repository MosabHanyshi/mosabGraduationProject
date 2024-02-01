class User {
  late int? id;
  late String? firstName;
  late String? lastName;
  late String? email;
  late String? phone;
  late String? pass;
  late String? pic;


  String get fullName => (firstName ?? "")+"  " + (lastName ?? "");

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.pass,
    this.pic

  });

  User copyWith({
     int? id,
     String? firstName,
     String? lastName,
     String? email,
     String? phone,
     String? pass,
    String? pic
  }) {
    return User(
      id:id ?? this.id,
      firstName:firstName ?? this.firstName,
      lastName:lastName ?? this.lastName,
      email: email ?? this.email,
      phone:phone ?? this.phone,
      pass:pass ?? this.pass,
      pic:pic??this.pic

    );
  }
  Map<String, dynamic> toJson(){
    return {
      'user_id':id,
      'firstName':firstName,
      'lastName':lastName,
      'user_email':email,
      'phone':phone,
      'user_password':pass,
      'pic':pic
    };
  }
  User.fromJson(Map<String, dynamic> json) {
    id = json["user_id"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["user_email"];
    phone = json["phone"];
    pass = json["user_password"];
    pic=json['pic'];

  }
}
