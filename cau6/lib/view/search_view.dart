import 'package:flutter/material.dart';
import 'dart:async';
import '../controller/product_controller.dart';
import '../data/models/product_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final ProductController _controller = ProductController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  
  List<Product> _products = [];
  bool _isLoading = false;
  String _error = '';

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _products = [];
        _error = '';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final results = await _controller.searchProducts(query);
      setState(() {
        _products = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 6 - Nguyễn Su Bin - 6451071065', style: TextStyle(fontSize: 16)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Nhập từ khóa tìm kiếm...',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error.isNotEmpty) {
      return Center(child: Text(_error, style: const TextStyle(color: Colors.red)));
    }
    if (_searchController.text.isEmpty) {
      return const Center(child: Text('Gõ gì đó để tìm kiếm sản phẩm'));
    }
    if (_products.isEmpty) {
      return const Center(child: Text('Không tìm thấy sản phẩm nào.'));
    }

    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return Card(
          child: ListTile(
            title: Text(product.title, maxLines: 1),
            subtitle: Text('\$${product.price}', style: const TextStyle(color: Colors.green)),
            leading: CircleAvatar(child: Text('${product.id}')),
          ),
        );
      },
    );
  }
}
