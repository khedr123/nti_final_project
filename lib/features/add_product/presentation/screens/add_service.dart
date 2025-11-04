import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nti_final_project/screens/widgets/custom_textformfield.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  bool isLoading = false;

  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController imageController = TextEditingController();


  final Dio dio = Dio();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> addService() async {
    setState(() => isLoading = true);

    try {
      final Response response = await dio.post(
        'https://accessories-eshop.runasp.net/api/products',
        data: {
          "sellerId": "d051dbf3-f5d8-410d-0e50-08de06562562",
          "name": serviceNameController.text.trim(),
          "description": descriptionController.text.trim(),
          "nameArabic": "ar",
          "descriptionArabic": "ع",
          "coverPictureUrl":imageController.text,
          "price": double.tryParse(priceController.text) ?? 1,
          "stock": int.tryParse(stockController.text) ?? 1,
          "weight": 1,

          "color": "black",
        },
      );

      log("Response: ${response.data}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Product added successfully!')),
      );
    } catch (e, s) {
      log('Error: $e\nStack: $s');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('❌ Failed to add product')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      addService();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 222, 1),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F5DE),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: const Text(
          'Add New Product',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Form(
            key: _formKey, // ✅ Added form key
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'image',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                CustomTextfield(
                  label: 'Image',
                  controller: imageController,
                  obscureText: false,
                ),
                const Text(
                  'Service Name',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                CustomTextfield(
                  label: 'Service Name',
                  controller: serviceNameController,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                CustomTextfield(
                  label: 'Description',
                  controller: descriptionController,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Price',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                CustomTextfield(
                  label: 'Price',
                  controller: priceController,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Category',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                CustomTextfield(
                  label: 'Category',
                  controller: categoryController,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Stock',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                CustomTextfield(
                  label: 'Stock',
                  controller: stockController,
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffA3856E),
                    minimumSize: const Size(double.infinity, 60),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Add Product',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
