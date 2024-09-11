class UserModel {
  final String name;
  final String profilePic;
  final double latitude;
  final double longitude;

  UserModel({
    required this.name,
    required this.profilePic,
    required this.latitude,
    required this.longitude,
  });
}

List<UserModel> dummyUsers = [
  UserModel(
      name: 'Hasan Yoldaş',
      profilePic: 'assets/person.png',
      latitude: 39.9334,
      longitude: 32.8597),
  UserModel(
      name: 'Merve Kaya',
      profilePic: 'assets/person.png',
      latitude: 40.7488,
      longitude: 30.7651),
  UserModel(
      name: 'Ahmet Demir',
      profilePic: 'assets/person.png',
      latitude: 41.0082,
      longitude: 28.9784),
  UserModel(
      name: 'Zeynep Şahin',
      profilePic: 'assets/person.png',
      latitude: 38.4237,
      longitude: 27.1428),
  UserModel(
      name: 'Ali Vural',
      profilePic: 'assets/person.png',
      latitude: 37.0662,
      longitude: 37.3833),
  UserModel(
      name: 'Deniz Aslan',
      profilePic: 'assets/person.png',
      latitude: 40.6401,
      longitude: 35.8102),
  UserModel(
      name: 'Mehmet Yıldız',
      profilePic: 'assets/person.png',
      latitude: 36.7166,
      longitude: 30.7020),
  UserModel(
      name: 'Elif Güner',
      profilePic: 'assets/person.png',
      latitude: 39.9208,
      longitude: 32.8541),
  UserModel(
      name: 'Emre Can',
      profilePic: 'assets/person.png',
      latitude: 38.3687,
      longitude: 34.0360),
  UserModel(
      name: 'Ayşe Kılıç',
      profilePic: 'assets/person.png',
      latitude: 39.9334,
      longitude: 32.8597),
];
