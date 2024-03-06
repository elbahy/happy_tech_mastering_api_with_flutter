class UserDataModel {
  User? user;

  UserDataModel({this.user});

  @override
  String toString() => 'UserData(user: $user)';

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
      );
}

class User {
  Location? location;
  String? id;
  String? name;
  String? phone;
  String? email;

  DateTime? createdAt;

  User({
    this.location,
    this.id,
    this.name,
    this.phone,
    this.email,
    this.createdAt,
  });

  @override
  factory User.fromJson(Map<String, dynamic> json) => User(
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
        id: json['_id'] as String?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
      );
}

class Location {
  String? type;
  List<dynamic>? coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json['type'] as String?,
        coordinates: json['coordinates'] as List<dynamic>?,
      );
}
