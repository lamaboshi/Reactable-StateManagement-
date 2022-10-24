import 'package:flutter/material.dart';
import 'package:overlayment/overlayment.dart';
import 'package:reactable/reactable.dart';

import 'data/model/cart.dart';
import 'data/repo/repositre.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<NavigatorState>();
    Overlayment.navigationKey = key;
    return MaterialApp(
      navigatorKey: key,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var repo = DataRepo();

  var cart = Cart().asReactable;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    cart.value = await repo.getCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.purple,
        backgroundColor: Colors.transparent,
        title: Text(
          'Shop to buy',
          style: styl(40),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background1.png',
            fit: BoxFit.cover,
          ),
          Scope(
            where: () => cart.value.limit != 0,
            builder: (_) => SingleChildScrollView(
              child: Wrap(
                children: cart.value.carts!
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          child: ListTile(
                              title: Text(
                                e.discountedTotal.toString(),
                                style: styl(25),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    'Befor DisCount : ',
                                    style: styl(17),
                                  ),
                                  Text(
                                    e.total.toString(),
                                    style: styl(17),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                e.userId.toString(),
                                style: styl(25, color: Colors.purple),
                              ),
                              leading: Text(
                                e.totalQuantity.toString(),
                                style: styl(25),
                              )),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle styl(double size, {Color color = Colors.black45}) =>
      TextStyle(fontFamily: 'Crimson Text', fontSize: size, color: color);
}
