import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_firebase/Modals/fire_modal.dart';

import '../Controller/Notificastion_Controller.dart';
import '../helperes/firebase_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController ProductName = TextEditingController();
  TextEditingController ProductPrice = TextEditingController();
  TextEditingController ProductDes = TextEditingController();
  TextEditingController ProductCategory = TextEditingController();
  TextEditingController ProducImage = TextEditingController();
  NotificationController notificationController =
  Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    notificationController.initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                const Icon(
                  Icons.sort,
                  size: 30,
                  color: Color(0xff4c53a5),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "My Shop",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4c53a5)),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add),
                  color: const Color(0xff4c53a5),
                  style: IconButton.styleFrom(fixedSize: const Size(40, 40)),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Add Product"),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: ("Product Name")),
                            ),
                            const SizedBox(height: 5),
                            const TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: ("Product Price")),
                            ),
                            const SizedBox(height: 5),
                            const TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: ("Product Description")),
                            ),
                            const TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: ("Product Image")),
                            ),
                            const SizedBox(height: 5),
                            const TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: ("Product Category")),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      FireHelper.fireHelper.addData(
                                          ProductName: ProductName.text,
                                          ProductPrice: ProductPrice.text,
                                          ProductDes: ProductDes.text,
                                          ProductImage: ProducImage.text,
                                          ProductCategory:
                                          ProductCategory.text);
                                    },
                                    child: const Text("Insert")),
                                const SizedBox(width: 5),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("cancel")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
              color: Color(0xffedecf2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        height: 500,
                        width: 300,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: ("Search here..."),
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.camera_alt,
                        size: 27,
                        color: Color(0xff4c53a5),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: const Text(
                    "Categories",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4c53a5)),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            "https://n1.sdlcdn.com/imgs/a/o/i/Woodland-Gd1033111w13-Blue-Casual-Sandals-SDL899507576-1-faec3.jpg",
                            width: 40,
                            height: 40,
                          ),
                          const Text(
                            "Sandal",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xff4c53a5)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: const Text(
                    "Best Selling",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4c53a5)),
                  ),
                ),
                StreamBuilder(
                  stream: FireHelper.fireHelper.readData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      QuerySnapshot? rawData = snapshot.data;
                      List<DataBookModal> l1 = [];
                      var docs = rawData!.docs;
                      for (var x in docs) {
                        DataBookModal d1 = DataBookModal(
                          ProductName: x['ProductName'],
                          ProductPrice: x['ProductPrice'],
                          ProductDes: x['ProductDes'],
                          ProductImage: x['ProductImage'],
                          ProductCategory: x['ProductCategory'],
                        );
                        l1.add(d1);
                      }
                      return GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.68,
                        shrinkWrap: true,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Image.network(
                                      "https://n1.sdlcdn.com/imgs/a/o/i/Woodland-Gd1033111w13-Blue-Casual-Sandals-SDL899507576-1-faec3.jpg",
                                      height: 90,
                                      width: 100,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Woodland Sandal",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff4c53a5)),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "No.1 Sandal",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff4c53a5)),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "\$55",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff4c53a5)),
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                  color: const Color(0xff4c53a5),
                                  onPressed: () {
                                    notificationController
                                        .showSimpleNotification();
                                  },
                                  icon:
                                  const Icon(Icons.shopping_cart_checkout),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        onTap: (index) {},
        color: const Color(0xff4c53a5),
        height: 70,
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            CupertinoIcons.cart_fill,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
