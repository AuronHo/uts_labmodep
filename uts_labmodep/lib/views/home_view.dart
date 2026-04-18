import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../widgets/custom_data_card.dart';
import '../widgets/shimmer_loading.dart';
import '../widgets/error_view.dart';

// 1. The Blueprint (This is what you likely accidentally deleted!)
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

// 2. The Engine (The updated logic we just built)
class _HomeViewState extends State<HomeView> {
  final ApiService _apiService = ApiService();
  List<UserModel> _allUsers = [];
  String _searchQuery = '';

  // Async Search & Load Logic
  Future<List<UserModel>> _getFilteredUsers() async {
    // Simulating a slight delay so the Shimmer loads beautifully
    await Future.delayed(const Duration(milliseconds: 200)); 
    
    // If the list is empty, fetch the data! 
    if (_allUsers.isEmpty) {
      _allUsers = await _apiService.fetchUsers();
    }

    // Filter the data based on the search box
    if (_searchQuery.isEmpty) return _allUsers;
    return _allUsers.where((user) => 
      user.name.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Directory')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<UserModel>>(
              future: _getFilteredUsers(), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ShimmerLoading(); 
                } else if (snapshot.hasError) {
                  return ErrorView( 
                    message: "Oops! We couldn't fetch the data. Check your connection.",
                    onRetry: () {
                      setState(() {}); 
                    },
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No users found.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return CustomDataCard(user: snapshot.data![index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}