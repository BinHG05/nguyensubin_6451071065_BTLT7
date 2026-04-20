import 'package:flutter/material.dart';
import '../controller/user_controller.dart';
import '../data/models/user_model.dart';

class UpdateUserView extends StatefulWidget {
  const UpdateUserView({super.key});
  @override
  State<UpdateUserView> createState() => _UpdateUserViewState();
}

class _UpdateUserViewState extends State<UpdateUserView> {
  final UserController _controller = UserController();
  final _formKey = GlobalKey<FormState>();
  
  UserModel? _user;
  bool _isLoading = true;
  bool _isUpdating = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await _controller.getUser(1);
      if (!mounted) return;
      setState(() {
        _user = user;
        _nameController.text = user.name;
        _emailController.text = user.email;
        _phoneController.text = user.phone;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _updateUser() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isUpdating = true);
    final updatedUser = UserModel(id: _user!.id, name: _nameController.text, email: _emailController.text, phone: _phoneController.text);
    try {
      final result = await _controller.updateUser(updatedUser);
      if (!mounted) return;
      setState(() {
        _user = result;
        _isUpdating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Update successful!'), backgroundColor: Colors.green));
    } catch (e) {
      if (!mounted) return;
      setState(() => _isUpdating = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bài 4 - Update User Info'), backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name'), validator: (v) => v!.isEmpty ? 'Enter name' : null),
                    const SizedBox(height: 16),
                    TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email'), validator: (v) => v!.isEmpty ? 'Enter email' : null),
                    const SizedBox(height: 16),
                    TextFormField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone'), validator: (v) => v!.isEmpty ? 'Enter phone' : null),
                    const SizedBox(height: 24),
                    ElevatedButton(onPressed: _isUpdating ? null : _updateUser, child: _isUpdating ? const CircularProgressIndicator() : const Text('Update')),
                    const SizedBox(height: 32),
                    if (_user != null) ...[
                      const Text('Updated Data from Server:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Name: ${_user!.name}\nEmail: ${_user!.email}\nPhone: ${_user!.phone}'),
                    ]
                  ],
                ),
              ),
            ),
    );
  }
}
