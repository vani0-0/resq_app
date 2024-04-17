import 'package:flutter/material.dart';
import 'package:hanap_app/pages/dashboard/dashboard.dart';
import 'package:hanap_app/pages/post/post.dart';

const List<Widget> destinations = [
  NavigationDestination(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  NavigationDestination(
    icon: Icon(Icons.calendar_month_sharp),
    label: 'Post',
  )
];

List<AppBar> appBars = [
  AppBar(
    title: const Text("Hanap App"),
  ),
  AppBar(
    title: const Text("Post Missing person"),
  )
];

List<Widget> bodies = [
  const DashboardPage(),
  const PostPage(),
];
