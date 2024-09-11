import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:map_cluster/features/home/home.dart';
import 'package:shimmer/shimmer.dart';
import '/core/core.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // #region veriables
  final double defaultLatitude = 39.9334; // Varsayılan konum (Ankara)
  final double defaultLongitude = 32.8597;

  late GoogleMapController mapController;

  late HomeCubit _homeCubit;
  // #endregion

  @override
  void initState() {
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    _homeCubit.fetchLocation();
    _homeCubit.distanceContext
        .setStrategy(HaversineDistance()); // Haversine stratejisini seçtik
    _homeCubit.loadMarkers(); // Markerları yükle
    super.initState();
  }

  void _zoomToUserLocation(UserModel user) {
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(user.latitude, user.longitude),
        6.0, // Zoom seviyesi (yaklaşık yakınlaştırma)
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _homeCubit.loadMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstanst.appTitle),
      ),
      body: BlocBuilder<HomeCubit, AppState>(builder: (context, state) {
        if (state is InitialState) {
          return const SizedBox();
        } else if (state is LoadingState) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: _buildBody(),
          );
        } else if (state is SuccessState) {
          return _buildBody();
        } else {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(StringConstanst.error),
              ],
            ),
          );
        }
      }),
    );
  }

  Center _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildMap(),
          _buildUsersCarousel(),
        ],
      ),
    );
  }

  Expanded _buildMap() {
    return Expanded(
      child: SizedBox(
        height: 450,
        //  / width: 350,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
              target: _homeCubit.currentLocation != null
                  ? LatLng(_homeCubit.currentLocation!.latitude,
                      _homeCubit.currentLocation!.longitude)
                  : LatLng(defaultLatitude, defaultLongitude),
              zoom: _homeCubit.currentZoom // Varsayılan zoom seviyesi
              ),
          markers: _homeCubit.markers,
          onCameraMove: (CameraPosition position) {
            _homeCubit.currentZoom = position.zoom;
            _homeCubit.loadMarkers();
          },
        ),
      ),
    );
  }

  Padding _buildUsersCarousel() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: CarouselSlider(
          items: _carouselUsers(),
          options: CarouselOptions(
            height: 500.0,
            aspectRatio: 14 / 10,
            viewportFraction: 0.80,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              // _current = index;

              _zoomToUserLocation(dummyUsers[index]);
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _carouselUsers() {
    List<Widget> carouselUsers = [];

    for (var i = 0; i < dummyUsers.length; i++) {
      carouselUsers
          .add(CarouselCardWidget(homeCubit: _homeCubit, user: dummyUsers[i]));
    }
    return carouselUsers;
  }
}
