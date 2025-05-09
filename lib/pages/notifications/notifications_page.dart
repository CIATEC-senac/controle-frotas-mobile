import 'package:alfaid/api/api.dart';
import 'package:alfaid/models/notification.dart';
import 'package:alfaid/widgets/scaffold_appbar.dart';
import 'package:daydart_flutter/daydart.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationModel> _notifications = [];
  bool _isLoading = false;

  void getNotifications() {
    setState(() {
      _isLoading = true;
    });

    API().getNotifications().then((notifications) {
      setState(() {
        _notifications = notifications;
      });
    }).catchError((e) {
      print('### Error: ${e.toString()}');
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    getNotifications();

    super.initState();
  }

  Widget getChildren() {
    if (_isLoading) {
      return const Center(
        child: Text('Carregando...'),
      );
    }

    return ListView.builder(
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
              onTap: () {
                API().setReadNotification(_notifications[index].id).then((_) {
                  _notifications[index].read = true;

                  setState(() {
                    _notifications = _notifications;
                  });
                }).catchError((e) {
                  print('### Error: ${e.toString()}');
                });
              },
              title: Text(
                _notifications[index].message,
              ),
              subtitle: Text(
                DayDart(_notifications[index].date)
                    .subtract(6, DayUnits.h)
                    .format('dd/MM/yyyy HH:mm:ss'),
              ),
              trailing: !_notifications[index].read
                  ? Container(
                      width: 8.0, // Tamanho do ponto
                      height: 8.0, // Tamanho do ponto
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange, // Cor do ponto
                      ),
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ScaffoldAppBar(
        title: 'Notificações',
        leadingBack: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: getChildren(),
      ),
    );
  }
}
