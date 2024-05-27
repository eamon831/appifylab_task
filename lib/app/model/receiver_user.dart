class ReceiverUser {
  final String? uid;
  final String? name;
  final String? email;
  final String? photoUrl;

  ReceiverUser({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
  });

  factory ReceiverUser.fromMap(Map<String, dynamic> map) {
    return ReceiverUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}
