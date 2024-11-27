import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lab6/BatteryService.dart';
import 'package:lab6/PermissionService.dart';
import 'package:lab6/product.dart';
import 'description_page.dart';

final List<Product> products = [
  Product(image:   "assets/images/nord_kit.png",
      image2: "assets/images/kit_2.png",
      image3: "assets/images/kit3.png",
      logoImage: "assets/images/nord_kit_photo.png",
      name:   "NORD KIT",
      company: "Smok®",
      cost: "26.90\$",
      firstColor:  "assets/images/nord1.png",
      secondColor: "assets/images/nord2.png",
      thirdColor:  "assets/images/nord3.png",
      fourthColor: "assets/images/nord4.png"),


  Product(image: "assets/images/eleaf.png",
      image2: "assets/images/kit_2.png",
      image3: "assets/images/kit_2.png",
      logoImage: "assets/images/eleaf_photo.png",
      name:   "Tance",
      company: "Eleaf",
      cost: "19.90\$",
      firstColor: "assets/images/tance1.png",
      secondColor: "assets/images/tance2.png",
      thirdColor: "assets/images/tance3.png",
      fourthColor: "assets/images/eleaf4.png"),

  Product(image: "assets/images/novo_2_kit.png",
      image2: "assets/images/kit_2.png",
      image3: "assets/images/kit_2.png",
      logoImage: "assets/images/novo_2_kit_photo.png",
      name:   "NOVO 2 KIT",
      company: "Smok®",
      cost: "25.90\$",
      firstColor: "assets/images/novo1.png",
      secondColor: "assets/images/novo2.png",
      thirdColor: "assets/images/novo3.png",
      fourthColor: "assets/images/novo4.png"),

  Product(image: "assets/images/ego_aio.png",
      image2: "assets/images/kit_2.png",
      image3: "assets/images/kit_2.png",
      logoImage: "assets/images/ego_aio_photo.png",
      name: "EGO AIO",
      company: "Joyetech",
      cost: "19.90\$",
      firstColor: "assets/images/ego1.png",
      secondColor: "assets/images/ego2.png",
      thirdColor: "assets/images/ego3.png",
      fourthColor: "assets/images/ego4.png")
];


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isPermissionGranted = false;
  Future<void> _checkPermission() async{
    try{
      final String permission = "android.permission.CAMERA";
      final bool result = await PermissionService.checkPermission(permission);
      setState(() {
        _isPermissionGranted = true;
      });
    }
    catch(e){
      setState(() {
        _isPermissionGranted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(253, 253, 253, 1),
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(253, 253, 253, 1),
            leading: InkWell(
              child: Image.asset("assets/icons/burger.png"),
              onTap: () {
                print("menu");
              },
            ),
            actions: <Widget>[
              InkWell(
                child: Image.asset("assets/icons/search.png"),
                onTap: () {
                  print("search");
                },
              ),
              const SizedBox(width: 10),
              InkWell(
                  child: const Icon(Icons.shopping_bag),
                  onTap: () async{
                    await _checkPermission();
                    final snackBar = SnackBar(
                      content: Text(_isPermissionGranted.toString()),
                      duration: Duration(seconds: 3),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }),
              const SizedBox(width: 20)
            ]),
        body: Column(
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.fromLTRB(15, 30, 0, 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("E-cigarettes",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      )),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 15, bottom: 15),
              child: SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      child: Center(
                          child: Stack(
                            children: <Widget>[
                              const Text(
                                "Popular",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ) ,
                              Positioned(
                                left: 1,
                                right: 55,
                                bottom: 0,
                                child: Container(
                                  height: 2.0,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 100,
                      child: Center(
                        child: Text(
                          "Featured",
                          style: TextStyle(
                              fontSize: 22,
                              color: Color.fromRGBO(180, 180, 180, 1),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                      child: Center(
                        child: Text(
                          "New",
                          style: TextStyle(
                              fontSize: 22,
                              color: Color.fromRGBO(180, 180, 180, 1),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      child: Center(
                          child: Text(
                            "Coming soon",
                            style: TextStyle(
                                fontSize: 22,
                                color: Color.fromRGBO(180, 180, 180, 1),
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionPage(product: product) ));
                      },
                      child: Container(
                        margin:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        padding: const EdgeInsets.only(left: 0, top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 12,
                                  offset: const Offset(0, 2))
                            ]),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 10),
                              child: Image.asset(
                                product.logoImage,
                                width: 120,
                                height: 118,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                        product.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                    RatingBar.builder(
                                      initialRating: 2.5,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      ignoreGestures: true,
                                      itemCount: 3,
                                      itemSize: 20,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.black,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Text(
                                          product.company,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Color.fromRGBO(180, 180, 180, 1),
                                              fontWeight: FontWeight.w500),
                                        ))
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 130,
                                          child: Text(
                                            product.cost,
                                            style: const TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 92,
                                          child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(25),
                                                  ),
                                                  child: Image.asset(
                                                    product.firstColor,
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                ),
                                                Image.asset(product.secondColor,
                                                    width: 20, height: 20),
                                                Image.asset(product.thirdColor,
                                                    width: 20, height: 20),
                                                Image.asset("assets/icons/plus.png",
                                                    width: 20, height: 20),
                                              ]),
                                        )
                                      ],
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ],
        ));
  }
}
