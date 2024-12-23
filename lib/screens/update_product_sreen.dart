import 'package:firebase.demo.app/data/firebase_service.dart';
import 'package:firebase.demo.app/data/product_firebase_service.dart';
import 'package:firebase.demo.app/screens/product_model.dart';
import 'package:flutter/material.dart';

class UpdateDataScreen extends StatefulWidget {
  final ProductModel product;
  const UpdateDataScreen({
    super.key,
    required this.product,
  });

  @override
  State<UpdateDataScreen> createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends State<UpdateDataScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productQuantityController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    productNameController.text = widget.product.name;
    productQuantityController.text = widget.product.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Post New Item',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Product's Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            TextField(
              controller: productNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Input Product's name..."),
            ),
            const Text(
              "Product's Quantity (kg)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            TextField(
              controller: productQuantityController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Input Product's quantity..."),
            ),
            const SizedBox(height: 30),
            Center(
              child: GestureDetector(
                onTap: () {
                  ProductFirebaseService.editProduct(
                      id: widget.product.id,
                      name: productNameController.text,
                      quantity: productQuantityController.text);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: const Color(0xff229250)),
                  child: const Center(
                    child: Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
