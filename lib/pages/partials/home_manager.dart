import 'dart:async';

import 'package:alfaid/api/api.dart';
import 'package:alfaid/models/notification.dart';
import 'package:alfaid/models/user.dart';
import 'package:alfaid/pages/manager/history_route_page.dart';
import 'package:alfaid/pages/notifications/notifications_page.dart';
import 'package:alfaid/widgets/list_item.dart';
import 'package:flutter/material.dart';

class ManagerHomePartial extends StatefulWidget {
  @override
  State<ManagerHomePartial> createState() => _ManagerHomePartialState();
}

class _ManagerHomePartialState extends State<ManagerHomePartial> {
  List<NotificationModel> _notifications = [];

  late Timer timer;

  void getNotifications() {
    API().getNotifications().then((notifications) {
      setState(() {
        _notifications = notifications;
      });
    }).catchError((e) {
      print('### Error: ${e.toString()}');
    });
  }

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(
        seconds: 60, //You can change second to milisecond etc
      ),
      (t) => getNotifications(),
    );

    getNotifications();

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListItem(
          title: 'Rotas finalizadas',
          subTitle: 'Aprovar rotas',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HistoryRoutePage(
                  role: UserRole.manager,
                ),
              ),
            );
          },
        ),
        ListItem(
          prefix: _notifications
                  .where((notification) => !notification.read)
                  .isNotEmpty
              ? Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange, // Cor do ponto
                  ),
                  margin: const EdgeInsets.only(right: 16.0),
                )
              : null,
          title: 'Notificações',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsPage(),
              ),
            ).then((_) {
              getNotifications();
            });
          },
        )
      ],
    );
  }
}
