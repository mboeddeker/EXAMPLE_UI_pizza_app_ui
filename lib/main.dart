// This example shows a [Scaffold] with an [AppBar], a [BottomAppBar] and a
// [FloatingActionButton]. The [body] is a [Text] placed in a [Center] in order
// to center the text within the [Scaffold] and the [FloatingActionButton] is
// centered and docked within the [BottomAppBar] using
// [FloatingActionButtonLocation.centerDocked]. The [FloatingActionButton] is
// connected to a callback that increments a counter.

import 'package:flutter/material.dart';
import 'package:pizza_app_ui/details.dart';
import 'package:pizza_app_ui/pizza.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pizza App',
      home: PizzaHome(),
      theme: ThemeData(primarySwatch: Colors.blueGrey, fontFamily: 'slabo'),
    );
  }
}

class PizzaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainApp(),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 50, right: 30),
      child: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[titleBar(), tabs()],
            ),
          )
        ],
      ),
    );
  }
}

Widget titleBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 70),
          Text(
            'Featured',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 50),
          )
        ],
      )
    ],
  );
}

Widget tabs() {
  return Container(
    height: 580,
    width: double.infinity,
    child: DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Container(
              color: Colors.transparent,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    TabBar(
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(top: 15.0),
                      indicatorColor: Colors.transparent,
                      labelColor: Colors.black,
                      labelStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w800, fontFamily: 'slabo'),
                      unselectedLabelColor: Colors.black26,
                      unselectedLabelStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w200, fontFamily: 'slabo'),
                      tabs: <Widget>[
                        Container(
                          child: Text('Pizza'),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 60.0),
                          child: Text('Rolls'),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 60),
                          child: Text('Burgers'),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 60),
                          child: Text('Sandwiches'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(children: <Widget>[
          pizzaShowCase(),
          Center(
            child: Text(
              'Rolls Tab',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ),
          Center(
            child: Text(
              'Burgers Tab',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ),
          Center(
            child: Text(
              'Sandwiches Tab',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ]),
      ),
    ),
  );
}

Widget pizzaShowCase() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 30),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: pizzaList.pizzas.length,
      itemBuilder: (BuildContext context, int i) {
        return ListOfPizzas(
            foreground: pizzaList.pizzas[i].foreground,
            background: pizzaList.pizzas[i].background,
            price: pizzaList.pizzas[i].price,
            name: pizzaList.pizzas[i].name,
            image: pizzaList.pizzas[i].image,
            pizzaObject: pizzaList.pizzas[i]);
      },
    ),
  );
}

class ListOfPizzas extends StatelessWidget {
  final Color foreground;
  final Color background;
  final double price;
  final String name;
  final String image;
  final Pizza pizzaObject;

  const ListOfPizzas(
      {Key key,
      @required this.foreground,
      @required this.background,
      @required this.price,
      @required this.name,
      @required this.image,
      @required this.pizzaObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onDoubleTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Details(pizzaObject)));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
            width: 225,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: 'PIZZAIMAGE$image',
                  child: SizedBox(
                    height: 180,
                    child: Image.asset(image),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                RichText(
                  softWrap: true,
                  text: TextSpan(style: TextStyle(color: foreground, fontSize: 25, fontFamily: 'slabo'), children: [
                    TextSpan(text: name),
                    TextSpan(
                      text: '\nPizza',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    )
                  ]),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '\$$price',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: foreground, fontFamily: 'arial'),
                      ),
                    ),
                    StatefulFavIcon(foreground: foreground),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 40,
        )
      ],
    );
  }
}

class StatefulFavIcon extends StatefulWidget {
  const StatefulFavIcon({@required this.foreground});

  final Color foreground;
  @override
  _StatefulFavIconState createState() => _StatefulFavIconState();
}

class _StatefulFavIconState extends State<StatefulFavIcon> {
  bool isFav;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFav = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFav = !isFav;
        });
      },
      child: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: widget.foreground,
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final double _size = 60;
  final double _padding = 17;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: _size + 15,
              width: _size + 15,
              padding: EdgeInsets.all(_padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  "https://yt3.ggpht.com/a-/ACSszfFz08Hdnl2SLB14PhBWwCLE72djU4N19ACaoA=s900-mo-c-c0xffffffff-rj-k-no",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              height: _size,
              width: _size,
              padding: EdgeInsets.all(_padding),
              child: Image.asset(
                'assets/home_icon.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: _size,
              width: _size,
              padding: EdgeInsets.all(_padding),
              child: Image.asset(
                'assets/search_icon.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: _size,
              width: _size,
              padding: EdgeInsets.all(_padding),
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(50)),
              child: Image.asset(
                'assets/bag_icon.png',
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
  }
}
