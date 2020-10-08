import 'package:flutter/material.dart';
import 'package:ggp_test/providers/user_info_provider.dart';
import 'package:provider/provider.dart';

class CheckInStatus extends StatelessWidget {
  const CheckInStatus({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.watch<UserInfoProvider>().checkInStatus == 3
            ? Text(
                'Check In Process',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue[400]),
              )
            : SizedBox.shrink(),
        SizedBox(height: 20),
        context.watch<UserInfoProvider>().checkInStatus < 3 &&
                context.watch<UserInfoProvider>().checkInStatus >= 0
            ? Text(
                'Check In Failed',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              )
            : SizedBox.shrink(),
        context.watch<UserInfoProvider>().checkInStatus == 2
            ? Text(
                'Anda berada diluar jangkauan',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.red),
              )
            : SizedBox.shrink(),
        context.watch<UserInfoProvider>().checkInStatus == 1
            ? Text(
                'Posisi anda belum di-set, pilih menu change location',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.red),
              )
            : SizedBox.shrink(),
        context.watch<UserInfoProvider>().checkInStatus == 0
            ? Text(
                'Anda sudah melakukan check-in hari ini',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.red),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
