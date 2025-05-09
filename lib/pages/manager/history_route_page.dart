import 'package:alfaid/api/api.dart';
import 'package:alfaid/models/history.dart';
import 'package:alfaid/models/history_approval.dart';
import 'package:alfaid/models/user.dart';
import 'package:alfaid/pages/manager/approbation_route_page.dart';
import 'package:alfaid/widgets/route/list_route_card.dart';
import 'package:flutter/material.dart';

class HistoryRoutePage extends StatefulWidget {
  final UserRole role;

  const HistoryRoutePage({super.key, required this.role});

  @override
  State<HistoryRoutePage> createState() => _HistoryRoutePageState();
}

class _HistoryRoutePageState extends State<HistoryRoutePage>
    with TickerProviderStateMixin {
  List<RouteHistoryModel> routes = List.empty();

  void getRoutesHistory() async {
    API().fetchRouteHistory().then((value) {
      setState(() {
        routes = value;
      });
    }).catchError((e) {
      print('Error: ${e.toString()}');
    });
  }

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    getRoutesHistory();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            const Text('Histórico de rotas', style: TextStyle(fontSize: 16.0)),
        bottom: TabBar(
          controller: tabController,
          tabs: const <Widget>[
            Tab(text: 'Pendente'),
            Tab(text: 'Aprovada'),
            Tab(text: 'Reprovada')
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          getList(HistoryStatus.pending),
          getList(HistoryStatus.approved),
          getList(HistoryStatus.disapproved),
        ],
      ),
    );
  }

  Widget getList(HistoryStatus? status) {
    List<RouteHistoryModel> filtered = routes
        .where((e) => (e.approval?.status ?? HistoryStatus.pending) == status)
        .toList();

    if (filtered.isEmpty) {
      return const Center(child: Text('Nada para visualizar'));
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) => ListRouteCard(
          history: filtered[index],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ApprobationRoutePage(
                  history: filtered[index],
                  role: widget.role,
                ),
              ),
            ).then((_) {
              getRoutesHistory();
            });
          },
        ),
      ),
    );
  }
}
