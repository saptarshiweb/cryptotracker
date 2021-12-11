// not just splash , will ask use for their name here

import 'package:expense/auth.config.dart';
import 'package:expense/controllers/db_helper.dart';
import 'package:expense/pages/crypto/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_glow/flutter_glow.dart';

import 'package:email_auth/email_auth.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  /// The boolean to handle the dynamic operations
  bool submitValid = false;

  String val = "";

  /// Text editing controllers to get the value from text fields
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();

  // Declare the object
  // ignore: unnecessary_new
  EmailAuth emailAuth = new EmailAuth(sessionName: "Sample session");

  bool isclear = false;
  bool otpenter = false;

  bool isthere = false;

  bool email = false;
  bool gogle = false;

  /// a void function to verify if the Data provided is true
  /// Convert it into a boolean function to match your needs.
  bool verify() {
    var res = (emailAuth.validateOtp(
        recipientMail: _emailcontroller.value.text,
        userOtp: _otpcontroller.value.text));

    return res;
  }

  /// a void funtion to send the OTP to the user
  /// Can also be converted into a Boolean function and render accordingly for providers
  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: _emailcontroller.value.text, otpLength: 5);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
  }

  //
  DbHelper dbHelper = DbHelper();

  String name = "";

  @override
  void initState() {
    super.initState();

    // ignore: unnecessary_new
    emailAuth = new EmailAuth(
      sessionName: "Sample Session",
    );
    emailAuth.config(remoteServerConfiguration);
    getName();
  }

  Future getName() async {
    String? name = await dbHelper.getName();

    if (name != null) {
      isthere = true;
      val = name;
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => HomePageSingleColor(),
      //   ),
      // );
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      //

      //
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.grey.shade300,
              Colors.grey.shade300,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: FutureBuilder(
              future: getName(),
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return Center(
                //     child: Container(
                //       decoration: BoxDecoration(
                //         color: Colors.white70,
                //         borderRadius: BorderRadius.circular(
                //           12.0,
                //         ),
                //       ),
                //       padding: EdgeInsets.all(
                //         16.0,
                //       ),
                //       child: Image.asset(
                //         "assets/icon.png",
                //         width: 64.0,
                //         height: 64.0,
                //       ),
                //     ),
                //   );
                // }

                if (val != "") {
                  return welcome();
                }

                if (isclear == true) {
                  return callyou();
                } else {
                  return emailverify();
                }
              }),
        ),
      ),
    );
  }

  Widget welcome() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/crypto1.jpg'), fit: BoxFit.fill)),
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlowText(
                  'CRYPTOTRACKER  ',
                  glowColor: Colors.purple.shade400,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ale1',
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.signInAlt,
                  color: Colors.white,
                  size: 38,
                )
              ],
            ),
          ),
          SizedBox(
            height: 150,
          ),
          // Image(
          //   image: AssetImage('assets/crypto.jpg'),
          //   height: 300,
          //   width: 300,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GlowText(
                '    Hello $val ',
                glowColor: Colors.deepOrange.shade300,
                style: TextStyle(
                  fontFamily: 'lato',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              FaIcon(
                FontAwesomeIcons.handHoldingHeart,
                color: Colors.white,
                size: 34,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 130, 0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePagecrypto()));
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    write('Start Trading ', 20, Colors.white, true),
                    Icon(
                      Icons.navigation_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple.shade900,
                onPrimary: Colors.lightGreenAccent.shade700,
              ),
            ),
          ),

          SizedBox(
            height: 350,
          ),
        ],
      ),
    );
  }

  Widget callyou() {
    return Padding(
      padding: const EdgeInsets.all(
        12.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.0,
          ),

          Center(
            child: Text(
              'CRYPTOTRACKER',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'ale1',
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.bitcoin,
                color: Colors.black,
                size: 100,
              ),
              SizedBox(
                width: 6,
              ),
              FaIcon(
                FontAwesomeIcons.ethereum,
                color: Colors.black,
                size: 100,
              ),
              SizedBox(
                width: 5,
              ),
              FaIcon(
                FontAwesomeIcons.ccPaypal,
                color: Colors.black,
                size: 100,
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),

          SizedBox(
            height: 30,
          ),

          Text(
            "  What should we Call You ?",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'lato',
              color: Colors.black,
            ),
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          //
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Your Name",
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 28.0,
                fontFamily: 'lato',
                fontWeight: FontWeight.bold,
              ),
              maxLength: 12,
              onChanged: (val) {
                name = val;
              },
            ),
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          //
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey.shade900,
              ),
              onPressed: () async {
                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(
                        label: "OK",
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                      backgroundColor: Colors.white,
                      content: Text(
                        "Please Enter a name",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  );
                } else {
                  DbHelper dbHelper = DbHelper();
                  await dbHelper.addName(name);
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (context) => HomePagecrypto(),
                  //   ),
                  // );

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePagecrypto()));
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Let's Start",
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'lato',
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Icon(
                    Icons.send_sharp,
                    size: 24.0,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 400,
          ),
        ],
      ),
    );
  }

  Widget emailverify() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          // Center(
          //   child: Text(
          //     'CRYPTOTRACKER',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontFamily: 'ale1',
          //       fontSize: 40,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.userCheck,
                  color: Colors.black, size: 100),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              write('Get Your Money', 34, Colors.black, true),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              write('Under Control', 32, Colors.black, true),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              write('Manage your Expenses', 22, Colors.blueGrey.shade900, true),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              write('Mock Trade CryptoCurrency', 22, Colors.blueGrey.shade900,
                  true),
            ],
          ),

          SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey.shade900,
              ),
              onPressed: () {
                setState(() {
                  email = true;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    write('Sign Up With Email Id   ', 24, Colors.white, true),
                    FaIcon(
                      FontAwesomeIcons.signInAlt,
                      color: Colors.white,
                      size: 24,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 9,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade200,
              ),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.black,
                      size: 24,
                    ),
                    write('  Sign Up with Google', 24, Colors.black, true),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(
            height: 12,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              write('Already have an account ? ', 21, Colors.blueGrey.shade900,
                  true),
              Text(
                "Sign In",
                style: TextStyle(
                  fontFamily: 'lato',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black,
                  fontSize: 20,
                ),
              )
            ],
          ),
          email == false
              ? SizedBox(
                  height: 0,
                  width: 0,
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            SizedBox(
                              width: 20,
                            ),
                            write('Complete the Process', 22,
                                Colors.blueGrey.shade900, true),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    email = false;
                                  });
                                },
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.blueGrey.shade900,
                                  size: 28,
                                )),
                            SizedBox(
                              width: 10,
                            )
                          ]),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              write('Email OTP Verification     ', 22,
                                  Colors.black, true),
                              SizedBox(
                                width: 5,
                              ),
                              FaIcon(
                                FontAwesomeIcons.userLock,
                                color: Colors.black,
                                size: 26,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _emailcontroller,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Your Email ',
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                        fontFamily: 'lato',
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: 'lato',
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              sendOtp();

                              setState(() {
                                otpenter = true;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  write('Send OTP ', 23, Colors.white, true),
                                  Icon(
                                    Icons.send_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  )
                                ],
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey.shade900,
                              onPrimary: Colors.lightGreenAccent.shade700,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

          otpenter == true
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        otpenter = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.blueGrey.shade900,
                                      size: 28,
                                    )),
                                SizedBox(
                                  width: 10,
                                )
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              write('OTP Verification   ', 25, Colors.black,
                                  true),
                              Icon(
                                Icons.verified_sharp,
                                color: Colors.black,
                                size: 30,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              write('Check your email Id. We have sent ', 17,
                                  Colors.blueGrey.shade700, true),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              write('you the OTP at ' + _emailcontroller.text,
                                  17, Colors.blueGrey.shade700, true),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _otpcontroller,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Your OTP ',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: 'lato',
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'lato',
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                            child: ElevatedButton(
                              onPressed: () {
                                if (verify() == true) {
                                  setState(() {
                                    isclear = true;
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    write(
                                        'Verify OTP ', 22, Colors.white, true),
                                    Icon(
                                      Icons.verified_user_sharp,
                                      color: Colors.white,
                                      size: 24,
                                    )
                                  ],
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey.shade900,
                                onPrimary: Colors.green.shade900,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          write('Did not receive the code ?', 18,
                              Colors.blueGrey.shade700, true),
                          Text(
                            'Re-Send Code',
                            style: TextStyle(
                              color: Colors.blueGrey.shade900,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blueGrey.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              fontFamily: 'lato',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                ),
          SizedBox(
            height: 400,
          ),
        ],
      ),
    );
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
