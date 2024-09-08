class AccessToken {
  //
  final String token;

  final DateTime ttl;


  AccessToken({
    required this.token,
    required this.ttl,
  });

  AccessToken.create({
    required this.token,
  })  : ttl = DateTime.now().add(const Duration(days: 7));

  factory AccessToken.fromMap(Map<dynamic, dynamic> map) {
    return AccessToken(
      token: map['token'],
      ttl: DateTime.parse(map['ttl']),
    );
  }

  toMap() {
    return {
      'token': token,
      'ttl': ttl.toString(),
    };
  }

  bool canUse() {
    return !ttl.difference(DateTime.now()).isNegative;
  }

  
}
