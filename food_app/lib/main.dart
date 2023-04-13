import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8ADAA),
      appBar: AppBar(
        title: Text(
          'Food App',
          style: mystyle(Colors.black45, 22, FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffEDEDED),
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            )),
        shadowColor: Colors.black,
        elevation: 10,
        bottomOpacity: 10,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
            padding: EdgeInsets.only(right: 10),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 20),
              child: RichText(
                //this widget is used to Highlet individual Text
                text: TextSpan(
                  text: 'Delicious Food',
                  style: mystyle(Colors.black, 20, FontWeight.bold),
                  children: const <TextSpan>[
                    TextSpan(
                        text: 'is',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    TextSpan(
                        text: ' waiting for you..',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
            ),
            Container(
              //this container is for textfield
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white)),
                    fillColor: Colors.grey[200],
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Colors.black),
              ),
            ),
            ListView.separated(
                //this widget is used for generating Restaurant Data through Index and pass the data to Food List page which is stateful widget
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FoodList(
                            restaurant: myresList[index],
                            foodlist: myList[index]),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffECC5C0),
                          border: Border.all(
                            width: 1,
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                blurStyle: BlurStyle.normal,
                                color: Colors.black)
                          ]),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            child: Stack(children: [
                              Image.asset(
                                myresList[index].img,
                                fit: BoxFit.cover,
                              )
                            ]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                myresList[index].name,
                                style:
                                    mystyle(Colors.black, 18, FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_sharp,
                                            color: Colors.pink,
                                          ),
                                          Text(
                                            myresList[index].range,
                                            style: mystyle(Colors.black38, 14,
                                                FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.orangeAccent,
                                          ),
                                          Text(
                                            myresList[index].rating,
                                            style: mystyle(Colors.black38, 14,
                                                FontWeight.w500),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  //this builder is used for seperate widgets through index
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: myresList
                    .length) //this refers to the length of Restaurant Data
          ],
        ),
      ),
    );
  }
}

class FoodList extends StatefulWidget {
  final restaurentModel restaurant; //this is a object for Restaurant data
  final Model foodlist; //this is a object for Food List data
  FoodList(
      {super.key,
      required this.restaurant,
      required this.foodlist}); //here we declare the constructor

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  var price;
  var delivery = 100;
  double _subTotalPrice = 0;
  int quantity = 1;

  getTotalPrice() {
    //this is function to get total data by pass for loop
    try {
      double total = 0;
      myList.forEach((item) {
        total += item.totalPrice ??
            item.price; //here total value could be total price of the products or single price of a product
        quantity >= 1
            ? delivery = 100
            : delivery =
                0; //if quantity is more than 1 than delivery charge is 100 otherwise it is 0
      });
      setState(() {
        _subTotalPrice = total +
            delivery; //it refresh the subtotalprice which is addition of total price and delivery charge
      });
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    getTotalPrice(); //here this get totalprice function executes when the project runs
    super.initState();
  }

  var isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8ADAA),
      appBar: AppBar(
        title: Text(
          'Cart',
          style: mystyle(Colors.black54, 20, FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffEDEDED),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        shadowColor: Colors.black,
        elevation: 10,
        bottomOpacity: 10,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSelected = true;
              });
            },
            icon: Icon(Icons.favorite,
                color: isSelected == true
                    ? Colors.red
                    : Colors
                        .black), //this logic is used to select the favourite icon
            padding: EdgeInsets.only(right: 10),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffECC5C0),
                  border: Border.all(
                    width: 1,
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        blurStyle: BlurStyle.normal,
                        color: Colors.black)
                  ]),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Color(0xffF5F5F5),
                          border: Border.all(
                            width: 1,
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                blurStyle: BlurStyle.normal,
                                color: Colors.black)
                          ]),
                      margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.asset(
                              myList[index].img,
                              fit: BoxFit.cover,
                            ),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${myList[index].title}",
                                  style: mystyle(
                                      Colors.black, 18, FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                          size: 18,
                                        ),
                                        Text(
                                          "${myList[index].rating}",
                                          style: mystyle(Colors.black, 16,
                                              FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Price:',
                                      style: mystyle(
                                          Colors.black, 18, FontWeight.bold),
                                    ),
                                    Text(
                                      "${myList[index].totalPrice ?? myList[index].price}",
                                      style: mystyle(
                                          Colors.black, 16, FontWeight.normal),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Quantity:',
                                      style: mystyle(Colors.purpleAccent, 20,
                                          FontWeight.normal),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          myList[index].quantity--;//this refers to the decrement of quantity

                                          myList[index].totalPrice =//this refers to the total price which is the multiplication of price and quantity
                                              myList[index].price *
                                                  myList[index].quantity;
                                          getTotalPrice();//here we call the getTotalPrice function
                                        });
                                      },
                                      icon: Icon(Icons.remove),
                                    ),
                                    Text(
                                      "${myList[index].quantity}",
                                      style: mystyle(
                                          Colors.black, 18, FontWeight.normal),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            myList[index]
                                                .quantity++; //this refers to the increment of quantity
                                            myList[index]
                                                    .totalPrice = //this refers to the total price which is the multiplication of price and quantity
                                                myList[index].price *
                                                    myList[index].quantity;
                                            getTotalPrice(); //here we call the getTotalPrice function
                                          });
                                        },
                                        icon: Icon(Icons.add))
                                  ],
                                )
                              ],
                            ),
                            flex: 3,
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return SizedBox(
                      height: 5,
                    );
                  },
                  itemCount: myList
                      .length), //here we declare the total length of foodlist
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffE2E2E3),
                  border: Border.all(
                    width: 1,
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        blurStyle: BlurStyle.normal,
                        color: Colors.black)
                  ]),
              margin: EdgeInsets.only(top: 20, left: 15, right: 15),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery',
                        style: TextStyle(fontSize: 30),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "$delivery", //here we refers the delivery charge
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₹',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Order', style: TextStyle(fontSize: 30)),
                      Row(
                        children: [
                          Text("$_subTotalPrice",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                          Text("₹",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(       //this refers to the show dialogue while click on Place order
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.orangeAccent,
                            title: Center(
                                child: Text(
                              'Your Order is Placed..',
                              style: mystyle(Colors.white, 25, FontWeight.bold),
                            )),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Center(
                          child: Text(
                        'Place Order',
                        style: mystyle(Colors.white, 25, FontWeight.bold),
                      )),
                    ),
                  )
                ],
              ),
            ),
            flex: 3,
          )
        ],
      ),
    );
  }
}

mystyle(Color clr, double size, FontWeight FontWeight) {
  return TextStyle(color: clr, fontSize: size, fontWeight: FontWeight);
}

class Model {    //this is Food List model class with some relatable variables
  int price;
  int? totalPrice;
  String? title;
  int quantity = 1;
  String img;
  double? rating;
  int deliverycharge = 100;

  Model({       //this is a constructor
    required this.img,
    required this.price,
    this.totalPrice,
    this.title,
    this.rating,
  });
}

List<Model> myList = [    //this is list of Food list data
  Model(
    img: 'food images/burger.png',
    price: 100,
    title: 'Burger',
    rating: 4.9,
  ),
  Model(
    img: 'food images/pizza.png',
    price: 300,
    title: 'Pizza',
    rating: 5.0,
  ),
  Model(
    img: 'food images/sub.png',
    price: 150,
    title: 'Sub Sandwich',
    rating: 4.3,
  ),
  Model(
    img: 'food images/chicken.png',
    price: 100,
    title: 'Chicken Fry',
    rating: 4.7,
  )
];
 
class restaurentModel {  //this is  restaurant model class
  String name;
  String place;
  String img;
  String rating;
  String range;
  restaurentModel(   //this is a constructor
      {required this.name,
      required this.place,
      required this.img,
      required this.range,
      required this.rating});
}

List<restaurentModel> myresList = [  //this is a list of restaurant  data
  restaurentModel(
      name: 'The Bombay Canteen',
      place: 'Mumbai',
      img: 'restaurant images/The Bombay Canteen.png',
      range: '1KM',
      rating: '4.9'),
  restaurentModel(
      name: 'The Table',
      place: 'Mumbai',
      img: 'restaurant images/The Table.png',
      range: '1KM',
      rating: '4.7'),
  restaurentModel(
      name: 'Cecconi’s',
      place: 'Mumbai',
      img: "restaurant images/Cecconi's.png",
      range: '1KM',
      rating: '4.9'),
  restaurentModel(
      name: 'Hakassan',
      place: 'Mumbai',
      img: 'restaurant images/Hakassan.png',
      range: '2KM',
      rating: '4.8'),
      
      
];
