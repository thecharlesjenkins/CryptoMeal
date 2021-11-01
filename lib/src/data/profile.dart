class Profile {
  String id;
  String name;
  String username;
  String phnumber;
  String cryptoKey;

  Profile(this.id, this.name, this.username, this.phnumber, this.cryptoKey);

  Profile.fromJson(String id, Map<String, dynamic> json)
      : this(id, json['name'], json['username'], json['phnumber'],
            json['crypto_key']);

  Profile.empty() : this("", "", "", "", "");

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'username': this.username,
        'phnumber': this.phnumber,
        'crypto_key': this.cryptoKey,
      };
}
