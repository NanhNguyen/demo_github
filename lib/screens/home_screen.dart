import 'package:firebase.demo.app/data/firebase_service.dart';
import 'package:firebase.demo.app/screens/book_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TextEditingController productNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<BookModel>>(
        stream: FirebaseService.booksStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          List<BookModel> bookList = snapshot.data ?? [];
          if (bookList.isEmpty) {
            return const Center(child: Text('No Data Found!'));
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: bookList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text('ID: ${bookList[index].id}'),
                  Text('Name: ${bookList[index].name}'),
                  Text('Type: ${bookList[index].type}'),
                  // TextField(
                  //   onChanged: (value) {},
                  //   controller: productNameController,
                  // )
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        FirebaseService.addBook(id: 1, name: "Harry Potter", type: "Sci-fi");
      }),
    );
  }
}
