class Profile {
  String id;
  String name;
  String username;
  String phnumber;

  Profile(this.id, this.name, this.username, this.phnumber);

  Map<String, dynamic> tojson() => {
        'id': this.id,
        'name': this.name,
        'username': this.username,
        'phnumber': this.phnumber,
      };
}
