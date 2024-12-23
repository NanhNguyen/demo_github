import 'package:firebase.demo.app/data/firebase_auth_service.dart';
import 'package:firebase.demo.app/data/product_firebase_service.dart';
import 'package:firebase.demo.app/screens/input_data_screen.dart';
import 'package:firebase.demo.app/screens/product_model.dart';
import 'package:firebase.demo.app/screens/update_product_sreen.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products List Detail',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuthService.signOut(context);
            },
            icon: const Icon(
              Icons.logout,
              size: 40,
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: ProductFirebaseService.productStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          List<ProductModel> productList = snapshot.data ?? [];
          if (productList.isEmpty) {
            return const Center(child: Text('No Data Found!'));
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UpdateDataScreen(product: productList[index]),
                        ));
                      },
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${productList[index].id}'),
                          Text('Name: ${productList[index].name}'),
                          Text(
                              'Quantity: ${productList[index].quantity} products'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                        onPressed: () {
                          ProductFirebaseService.deleteProduct(
                              id: productList[index].id);
                        },
                        icon: const Icon(Icons.delete))
                  ],
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff229250),
          child: const Center(
            child: Text('+', style: TextStyle(color: Colors.white)),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const InputDataScreen(),
            ));
          }),
    );
  }
}
