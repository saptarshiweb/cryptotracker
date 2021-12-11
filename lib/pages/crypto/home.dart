
import 'package:expense/pages/crypto/homescreen.dart';
import 'package:expense/pages/crypto/market.dart';
import 'package:expense/pages/crypto/model/local_auth_api.dart';


import 'package:expense/pages/homepage.dart';
import 'package:expense/pages/settings.dart';

import 'package:expense/pages/widgets/add_transaction2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HomePagecrypto extends StatefulWidget {
  static bool dark = true;

  const HomePagecrypto({Key? key}) : super(key: key);

  @override
  _HomePagecryptoState createState() => _HomePagecryptoState();
}

class _HomePagecryptoState extends State<HomePagecrypto> {
  Color bg = Colors.white;
  Color bg1 = Colors.white;
  Color bg2 = Colors.grey.shade900;
  Color look = Colors.black;
  Color look1 = Colors.black;
  Color look2 = Colors.white;

  Color all = Colors.grey.shade100;
  Color all1 = Colors.blueGrey.shade300;
  Color all2 = Colors.black;

  int _pageIndex = 0;
  late PageController _pageController;

  List<Widget> tabPages = [
    Homescreen(),
    HomePageSingleColor(),

    

    Marketscreen(),
    Settings(),
  ];

  get dark => null;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _pageIndex,
        onTap: onTabTapped,
        selectedItemColor: dark == false
            ? Colors.deepPurple.shade900
            : Colors.lightGreenAccent.shade400,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(fontFamily: 'lato', fontSize: 12),
        selectedLabelStyle: TextStyle(
            fontFamily: 'lato',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: dark == false
                ? Colors.deepPurple.shade800
                : Colors.lightGreenAccent.shade400),
        unselectedItemColor: dark == false ? Colors.black : Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 26,
              ),
              backgroundColor: dark == false ? Colors.white : Colors.black,
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 26,
              ),
              backgroundColor: dark == false ? Colors.white : Colors.black,
              label: 'PortFolio'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.auto_graph,
                size: 26,
              ),
              backgroundColor: dark == false ? Colors.white : Colors.black,
              label: 'Market'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 26,
              ),
              backgroundColor: dark == false ? Colors.white : Colors.black,
              label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        focusElevation: 0,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  color: Colors.black,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade900,
                              Colors.grey.shade900,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              write('    Choose the Options ', 18, Colors.white,
                                  true),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.deepOrange.shade600,
                                    size: 26,
                                  )),
                              SizedBox(
                                width: 6,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      final isAuthenticated =
                                          await LocalAuthApi.authenticate();

                                      if (isAuthenticated) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePageSingleColor()),
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          write('Authenticate ', 30,
                                              Colors.white, true),
                                          Icon(Icons.lock_open_outlined,
                                              color: Colors.white, size: 35)
                                        ],
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blueGrey.shade900,
                                      onPrimary:
                                          Colors.lightGreenAccent.shade400,
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(
                                        CupertinoPageRoute(
                                          builder: (context) => Transact(
                                            cash: 0,
                                            note1: '',
                                            expense: false,
                                            crypto: '',
                                            buyorsell: '',
                                            quantity: 0,
                                            rate: 0,
                                          ),
                                        ),
                                      )
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          write('   Trade   ', 30, Colors.white,
                                              true),
                                          Icon(
                                            Icons
                                                .account_balance_wallet_outlined,
                                            color: Colors.white,
                                            size: 32,
                                          ),
                                        ],
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blueGrey.shade900,
                                      onPrimary:
                                          Colors.lightGreenAccent.shade400,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: Icon(
          Icons.compare_arrows_outlined,
          size: 32,
          color: dark == false ? Colors.white : Colors.white,
        ),
        backgroundColor: dark == false
            ? Colors.deepPurple.shade900
            : Colors.deepOrange.shade900,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,

      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Text write(String s, double size, Color c, bool j) {
    return Text(
      s,
      style: TextStyle(
        fontSize: size,
        color: c,
        fontWeight: j == true ? FontWeight.bold : FontWeight.normal,
        fontFamily: 'lato',
      ),
    );
  }
}
