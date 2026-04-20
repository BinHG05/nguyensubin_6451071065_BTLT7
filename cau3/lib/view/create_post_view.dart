import 'package:flutter/material.dart';
import '../controller/post_controller.dart';
import '../data/models/post_model.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});
  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final PostController _controller = PostController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  bool _isLoading = false;
  String _response = '';

  Future<void> _createPost() async {
    if (_titleController.text.isEmpty || _bodyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng nhập Title và Body')));
      return;
    }
    setState(() {
      _isLoading = true;
      _response = '';
    });
    final newPost = PostModel(title: _titleController.text, body: _bodyController.text, userId: 1);
    try {
      final response = await _controller.createPost(newPost);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post created successfully'), backgroundColor: Colors.green));
      setState(() {
        _response = response.toString();
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: Colors.red));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bài 3 - Create Post'), backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [
        TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
        const SizedBox(height: 16),
        TextField(controller: _bodyController, decoration: const InputDecoration(labelText: 'Body'), maxLines: 3),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: _isLoading ? null : _createPost, child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Create Post')),
        const SizedBox(height: 24),
        if (_response.isNotEmpty) ...[
          const Text('Server Response:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(padding: const EdgeInsets.all(8), color: Colors.grey[200], width: double.infinity, child: Text(_response)),
        ]
      ])),
    );
  }
}
