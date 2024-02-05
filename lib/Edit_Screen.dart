import 'package:flutter/material.dart';
import 'package:restapicrudapp/ModelClass.dart';
import 'package:restapicrudapp/Style.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.Allinfo, });

  final Productkey Allinfo;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

final TextEditingController NameController = TextEditingController();
final TextEditingController CodeController = TextEditingController();
final TextEditingController ImageController = TextEditingController();
final TextEditingController PriceController = TextEditingController();
final TextEditingController QuantityController = TextEditingController();
final TextEditingController TotalController = TextEditingController();

final _FormKey = GlobalKey<FormState>();

class _EditScreenState extends State<EditScreen> {
  @override
  void initState() {
    NameController.text = widget.Allinfo.productName ?? "";
    CodeController.text = widget.Allinfo.productCode ?? "";
    ImageController.text = widget.Allinfo.Img ?? "";
    PriceController.text = widget.Allinfo.unitPrice ?? "";
    QuantityController.text = widget.Allinfo.qty ?? "";
    TotalController.text = widget.Allinfo.totalPrice ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text("Update Product"),
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
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorDarkBlue),
                      onPressed: () {
                        if (_FormKey.currentState!.validate()) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
