import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerLastSeen = TextEditingController();
  final TextEditingController _controllerLocation = TextEditingController();
  final TextEditingController _controllerBounty = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();
  

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Form(child: Column()),
    );
  }
}
