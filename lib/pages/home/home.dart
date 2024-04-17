import 'package:flutter/material.dart';
import 'package:hanap_app/pages/home/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars[currentPage],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onSelect,
        indicatorColor: const Color.fromRGBO(228, 151, 41, 1),
        selectedIndex: currentPage,
        destinations: destinations,
      ),
      body: bodies[currentPage],
    );
  }

  void _onSelect(int index) {
    setState(() {
      currentPage = index;
    });
  }
}
