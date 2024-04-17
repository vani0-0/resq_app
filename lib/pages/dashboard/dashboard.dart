import 'package:flutter/material.dart';
import 'package:hanap_app/models/content.dart';
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
          itemBuilder: (context, index) {
            Content content = missings[index].data();
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(content.name),
              ),
            );
          },
        );
      },
    );
  }
}
