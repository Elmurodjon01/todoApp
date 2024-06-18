// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserInfo {
  final String userid;
  final String created_at;
  final String username;
  UserInfo({
    required this.userid,
    required this.created_at,
    required this.username,
  });

  UserInfo copyWith({
    String? userid,
    String? created_at,
    String? username,
  }) {
    return UserInfo(
      userid: userid ?? this.userid,
      created_at: created_at ?? this.created_at,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'created_at': created_at,
      'username': username,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      userid: map['userid'] as String,
      created_at: map['created_at'] as String,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserInfo(userid: $userid, created_at: $created_at, username: $username)';

  @override
  bool operator ==(covariant UserInfo other) {
    if (identical(this, other)) return true;

    return other.userid == userid &&
        other.created_at == created_at &&
        other.username == username;
  }

  @override
  int get hashCode => userid.hashCode ^ created_at.hashCode ^ username.hashCode;
}
