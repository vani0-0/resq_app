import 'package:flutter/material.dart';
import 'package:hanap_app/pages/dashboard/missing_card.dart';
import 'package:hanap_app/services/database_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DatabaseService _dbService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _dbService.getMissings(),
      builder: (context, snapshot) {
        List missings = snapshot.data?.docs ?? [];
        if (missings.isEmpty) {
          return const Center(
            child: Text('No Missing Persons.'),
          );
        }
        return ListView.builder(
          itemCount: missings.length,
          itemBuilder: (context, index) => MissingCard(
            missing: missings[index].data(),
          ),
        );
      },
    );
  }
}
