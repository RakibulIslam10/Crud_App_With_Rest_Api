import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restapicrudapp/AddProductScreen.dart';
import 'package:restapicrudapp/Edit_Screen.dart';
import 'package:restapicrudapp/ModelClass.dart';
import 'package:restapicrudapp/Style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool Loding = false;
List<Productkey> ProductList = [];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.bell),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.settings),
          ),
        ],
        title: const Text("My Product"),
      ),
      body: ProductList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: GetJsonFormApi,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 245),
                  itemCount: ProductList.length,
                  itemBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorWhite,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54.withOpacity(0.2),
                                blurRadius: 10)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.network(
                              ProductList[index].Img ?? "No image",
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                            ),
                            child: Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Product Name : ${ProductList[index].productName ?? "Unknown"}"),
                                    const SizedBox(height: 1),
                                    Text(
                                        "Product Code : ${ProductList[index].productCode ?? "Unknown"}"),
                                    const SizedBox(height: 1),
                                    Text(
                                        "Quantity : ${ProductList[index].qty ?? "Unknown"}"),
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    Text(
                                        "Unit price : ${ProductList[index].unitPrice ?? "Unknown"}"),
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditScreen(
                                            Allinfo: ProductList[index]),
                                      ),
                                    );

                                    if (result != null && result == true) {
                                      Loding = true;
                                      GetJsonFormApi();
                                    }
                                  },
                                  child: const Text("Edit"),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      MyDialogBOx(ProductList[index].sId!),
                                  child: const Text("Delete"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorRed),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorDarkBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        icon: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(),
            ),
          );

          if (result != null && result == true) {
            Loding = true;
            GetJsonFormApi();
          }
        },
        label: const Text(
          "Add",
          style: TextStyle(fontSize: 16),
        ),
      ),
      drawer: Drawer(),
    );
  }

  void MyDialogBOx(String ProductsId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Delete!",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: ColorRed),
        ),
        content: const Text("Are you sure delete this?"),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          OutlinedButton(
            onPressed: () {
              DeleteProducdt(ProductsId);
              Navigator.pop(context);
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: ColorRed),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    GetJsonFormApi();
    super.initState();
    setState(() {});
  }

  Future<void> GetJsonFormApi() async {
    setState(() {
      Loding = true;
    });
    ProductList.clear();
    Uri MyUri = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
    Response response = await get(MyUri);
    var ResponseDecode = jsonDecode(response.body);
    if (response.statusCode == 200 && ResponseDecode["status"] == "success") {
      var jsonlist = ResponseDecode["data"];
      for (var items in jsonlist) {
        Productkey MyApikey = Productkey.fromJson(items);
        ProductList.add(MyApikey);
        setState(() {});
      }
      setState(() {
        Loding = true;
      });
    }
  }

  Future<void> DeleteProducdt(String ProductsId) async {
    setState(() {
      Loding = true;
    });
    Uri MyUri = Uri.parse(
        "https://crud.teamrabbil.com/api/v1/DeleteProduct/$ProductsId");
    Response response = await get(MyUri);
    var ResponseDecode = jsonDecode(response.body);
    if (response.statusCode == 200) {
      GetJsonFormApi();
    } else {
      setState(() {
        Loding = false;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Product Delete Faild!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            backgroundColor: ColorDarkBlue,
          ),
        );
      });
    }
  }
}
