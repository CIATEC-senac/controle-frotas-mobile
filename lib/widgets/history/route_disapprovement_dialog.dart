import 'package:alfaid/api/api.dart';
import 'package:alfaid/models/history.dart';
import 'package:alfaid/models/history_approval.dart';
import 'package:alfaid/pages/manager/history_route_page.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

Future<void> routeDisapprovementDialog(
    RouteHistoryModel history, BuildContext context) {
  TextEditingController controller = TextEditingController();

  Future<dynamic> goHome(context) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HistoryRoutePage()),
    );
  }

  void confirm(context) {
    var observation = controller.value.text;

    API()
        .updateHistoryStatus(history.id, HistoryStatus.disapproved, observation)
        .then((_) {
      toastification.show(
          callbacks: ToastificationCallbacks(
            onAutoCompleteCompleted: (_) => goHome(context),
            onDismissed: (_) => goHome(context),
          ),
          type: ToastificationType.success,
          title: const Text('Rota reprovada com sucesso'),
          alignment: Alignment.topCenter,
          autoCloseDuration: const Duration(seconds: 3),
          borderRadius: BorderRadius.circular(4.0),
          style: ToastificationStyle.flat);
      print('Deu certo, aeeeee');
    }).catchError((e) {
      print('Ih, deu ruim');
      print(e.toString());
    });
  }

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(16.0),
        shape: ShapeDecoration.fromBoxDecoration(
          BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        ).shape,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12.0,
            children: [
              Text(
                'Reprovar rota',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextField(
                minLines: 3,
                maxLines: 3,
                controller: controller,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText:
                      'Por favor, insira uma observação explicando o motivo da reprovação',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => {Navigator.pop(context)},
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => confirm(context),
                    child: const Text('Confirmar'),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
