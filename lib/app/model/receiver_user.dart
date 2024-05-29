class ReceiverUser {
  final String? uid;
  final String? name;
  final String? email;
  final String? phone;
  final String? photoUrl;

  ReceiverUser({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.photoUrl,
  });

  factory ReceiverUser.fromMap(Map<String, dynamic> map) {
    return ReceiverUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      photoUrl: map['photo_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
    };
  }
}
