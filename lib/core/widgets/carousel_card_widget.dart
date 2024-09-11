import 'package:flutter/material.dart';

import '/features/features.dart';
import '/core/core.dart';

class CarouselCardWidget extends StatefulWidget {
  const CarouselCardWidget(
      {super.key, required this.user, required this.homeCubit});
  final UserModel user;
  final HomeCubit homeCubit;

  @override
  State<CarouselCardWidget> createState() => _CarouselCardWidgetState();
}

class _CarouselCardWidgetState extends State<CarouselCardWidget> {
  final distanceContext = DistanceServiceContext();
  final double defaultLatitude = 39.9334; // Varsayılan konum (Ankara)
  final double defaultLongitude = 32.8597;
  double distance = 0;
  @override
  void initState() {
    distanceContext.setStrategy(
        HaversineDistance()); // Haversine stratejisini seçtik    super.initState();
    _initializeLocation();
    super.initState();
  }

  void _initializeLocation() async {
    _calculateDistance();
  }

  void _calculateDistance() {
    if (widget.homeCubit.currentLocation == null) return;
    distance = distanceContext.calculateDistance(
      widget.homeCubit.currentLocation!.latitude,
      widget.homeCubit.currentLocation!.longitude,
      widget.user.latitude,
      widget.user.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildUserCard(widget.user);
  }

  Widget _buildUserCard(UserModel user) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              _buildUserAvatar(user),
              _buildDistanceCard(distance),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildName(user),
              const SizedBox(height: 10),
              _buildDescription(distance),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildUserAvatar(UserModel user) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, right: 8),
      child: UserAvatarWidget(
        user: user,
      ),
    );
  }

  Container _buildDistanceCard(double distance) {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2),
        child: Text(
          maxLines: 2,
          "${distance.toStringAsFixed(0)} KM",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Text _buildName(UserModel user) {
    return Text(
      user.name,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text _buildDescription(double distance) {
    return Text(
      maxLines: 2,
      "${distance.toStringAsFixed(2)} km uzaklıkta",
      style: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }
}
