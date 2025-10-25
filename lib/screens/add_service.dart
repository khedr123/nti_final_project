import 'package:flutter/material.dart';
import 'package:nti_final_project/screens/widgets/custom_elevated_button';
import 'package:nti_final_project/screens/widgets/custom_textformfield.dart';

class AddService extends StatelessWidget {
  AddService({super.key});
  final TextEditingController serviceNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 222, 1),
      appBar: AppBar(
        backgroundColor: Color(0xffF5F5DE),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          'Add New Product',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                'Service Name',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              CustomTextfield(
                label: 'Service Name',
                controller: serviceNameController,
                obscureText: false,
              ),
              Text(
                'Description',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              CustomTextfield(
                label: 'Description',
                controller: serviceNameController,
                obscureText: false,
              ),
              Text(
                'Price',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              CustomTextfield(
                label: 'Price',
                controller: serviceNameController,
                obscureText: false,
              ),
              Text(
                'Category',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              CustomTextfield(
                label: 'Category',
                controller: serviceNameController,
                obscureText: false,
              ),
              Text(
                'Stock',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              CustomTextfield(
                label: 'Stock',
                controller: serviceNameController,
                obscureText: false,
              ),
              SizedBox(height: 20),
              CustomElevatedbutton(text: 'Add Service', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
