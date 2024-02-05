import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restapicrudapp/Style.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

final TextEditingController NameController = TextEditingController();
final TextEditingController CodeController = TextEditingController();
final TextEditingController ImageController = TextEditingController();
final TextEditingController PriceController = TextEditingController();
final TextEditingController QuantityController = TextEditingController();
final TextEditingController TotalController = TextEditingController();

final _FormKey = GlobalKey<FormState>();

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text("Create Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _FormKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter product name";
                  }
                  return null;
                },
                controller: NameController,
                decoration: MyDecoration("Product Name"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter product code";
                  }
                  return null;
                },
                controller: CodeController,
                decoration: MyDecoration("Product Code"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter product url";
                  }
                  return null;
                },
                controller: ImageController,
                decoration: MyDecoration("Image Url"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter product quantity";
                  }
                  return null;
                },
                controller: QuantityController,
                decoration: MyDecoration("Quantity"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter product Total Price";
                  }
                  return null;
                },
                controller: TotalController,
                decoration: MyDecoration("Total Price"),
              ),
              const SizedBox(height: 40),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Visibility(replacement: const CircularProgressIndicator(),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorDarkBlue),
                        onPressed: () {
                          if (_FormKey.currentState!.validate()) {
                            PostFormApi();
                            setState(() {
                              Loding = true;
                            });
                          }
                        },
                        child: Loding ? const CircularProgressIndicator() : const Text(
                          "Create",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )),
                  ))
            ],
          ),
        ),
      ),
    );
  }
  var Loding = false;

  Future<void>PostFormApi()async {
    setState(() {
      Loding = true;
    });
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");

    Map<String,dynamic>apiParams = {
      "Img":ImageController.text.trim(),
      "ProductCode":CodeController.text.trim(),
      "ProductName":NameController.text.trim(),
      "Qty":QuantityController.text.trim(),
      "TotalPrice":TotalController.text.trim(),
    };

    Response response = await post(uri,body: jsonEncode(apiParams),
        headers: {"Content-type": " application/json"}
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      ImageController.clear();
      NameController.clear();
      CodeController.clear();
      QuantityController.clear();
      TotalController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Product created successfully",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          backgroundColor: ColorDarkBlue,
        ),
      );
      Navigator.pop(context,true);
      setState(() {
        Loding = false;
      });

    }
  }
}