import 'package:flutter/material.dart';
import '../models/post_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final Post post;

  const DetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: post.id,
          child: Image.network(post.mobile),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          launchUrl(Uri.parse(post.raw));
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}