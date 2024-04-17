import 'package:flutter/material.dart';
import 'package:hanap_app/pages/post/create.form.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.all(12), child: CreateForm());
  }
}
