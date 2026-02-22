class User {
  final int id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String username;

  // Constructor
  User(this.id, this.firstName, this.lastName, this.fullName, this.email, this.username);

  // convert json to map object
  User.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      firstName = json['firstName'],
      lastName = json['lastName'],
      fullName = json['firstName'] + ' ' + json['lastName'],
      email = json['email'],
      username = json['username'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username
    };
  }
}
