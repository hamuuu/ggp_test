import 'package:flutter/material.dart';
import 'package:ggp_test/providers/user_info_provider.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CheckInTimer extends StatefulWidget {
  @override
  _CheckInTimerState createState() => _CheckInTimerState();
}

class _CheckInTimerState extends State<CheckInTimer> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(); // Create instance.

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _stopWatchTimer.rawTime,
      initialData: 0,
      builder: (context, snap) {
        final value = snap.data;
        final displaySecond = StopWatchTimer.getDisplayTimeSecond(value);
        final displayMillisecond =
            StopWatchTimer.getDisplayTimeMilliSecond(value);
        context.watch<UserInfoProvider>().checkoutButton
            ? _stopWatchTimer.onExecute.add(StopWatchExecute.start)
            : _stopWatchTimer.onExecute.add(StopWatchExecute.reset);

        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    displaySecond,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' : ',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    displayMillisecond,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
