import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_state.dart';

class SendLocation extends StatelessWidget {
  const SendLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) => {},
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: () async {
            bool serviceEnabled;
            LocationPermission permission;

            serviceEnabled = await Geolocator.isLocationServiceEnabled();
            if (!serviceEnabled) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Location services are disabled.')));
              return;
            }

            permission = await Geolocator.checkPermission();
            if (permission == LocationPermission.denied) {
              permission = await Geolocator.requestPermission();
              if (permission == LocationPermission.denied) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Location permissions are denied')));
                return;
              }
            }
            if (permission == LocationPermission.deniedForever) {
              // Permissions are denied forever, handle appropriately.
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'Location permissions are permanently denied, we cannot request permissions.')));
              return;
            }
            await Geolocator.getCurrentPosition().then((value) {
              userCubit.updateLocation(
                  // '{"lat": ${value.latitude}, "long": ${value.longitude}}'
                  '{"name":"egypt","address":"egypt","coordinates":[${value.latitude},${value.longitude}]}');
            });
          },
          child: const Icon(Icons.location_on_outlined),
        );
      },
    );
  }
}
