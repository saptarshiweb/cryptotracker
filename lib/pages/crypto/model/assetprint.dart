import 'package:expense/controllers/db_helper.dart';
import 'package:expense/pages/widgets/confirm_dialog.dart';
import 'package:expense/pages/widgets/info_snackbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:expense/static.dart' as Static;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Assettile extends StatefulWidget {
  const Assettile({Key? key}) : super(key: key);

  @override
  _AssettileState createState() => _AssettileState();
}

class _AssettileState extends State<Assettile> {
  //
  bool trans = true;
  Color bg = Colors.white;
  Color bg1 = Colors.white;
  Color bg2 = Colors.grey.shade900;
  Color look = Colors.white;
  Color look1 = Colors.black;
  Color look2 = Colors.white;

  bool dark = true;

  Color all = Colors.orangeAccent.shade100.withOpacity(0.3);
  Color all1 = Colors.blueGrey.shade300;
  Color all2 = Colors.black;

  late Box box;
  late SharedPreferences preferences;
  DbHelper dbHelper = DbHelper();
  Map? data;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  List<FlSpot> dataSet = [];
  List<BarChartGroupData> barChartData = [];
  DateTime today = DateTime.now();

  Color c=Colors.white;

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  void initState() {
    super.initState();
    getPreference();
    box = Hive.box('money');
  }

  getPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }
  //

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.teal.shade900,
        Colors.purple.shade900,
      ])),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<Map>(
            future: fetch(),
            builder: (context, snapshot) {
              // print(snapshot.data);
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Oopssss !!! There is some error !",
                  ),
                );
              }
              if (snapshot.hasData) {
                // if (snapshot.data!.isEmpty) {
                //   return Center(
                //     child: Text(
                //       "You haven't added Any Data !",
                //     ),
                //   );
                // }
                //

                return Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          write('AssetList ', 30, Colors.black, true),
                          FaIcon(FontAwesomeIcons.listAlt,
                          color: c,
                          size: 34,

                          ),
                        ],
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.all(12.0),
                      //   child: Row(
                      //     children: [
                      //       write('Recent Transactions', 23, look, true),
                      //       Spacer(),
                      //       trans == false
                      //           ? IconButton(
                      //               onPressed: () {
                      //                 setState(() {
                      //                   if (trans == true) {
                      //                     trans = false;
                      //                   } else {
                      //                     trans = true;
                      //                   }
                      //                 });
                      //               },
                      //               icon: Icon(
                      //                 Icons.arrow_drop_down_circle_sharp,
                      //                 color: Colors.lightGreenAccent.shade700,
                      //                 size: 36,
                      //               ),
                      //             )
                      //           : IconButton(
                      //               onPressed: () {
                      //                 setState(() {
                      //                   if (trans == true) {
                      //                     trans = false;
                      //                   } else {
                      //                     trans = true;
                      //                   }
                      //                 });
                      //               },
                      //               icon: Icon(
                      //                 Icons.cancel_presentation_outlined,
                      //                 color: Colors.deepOrangeAccent.shade400,
                      //                 size: 36,
                      //               ),
                      //             ),
                      //       SizedBox(
                      //         width: 20,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //
                      // trans == false
                      //     ? SizedBox(
                      //         height: 0,
                      //         width: 0,
                      //       )
                      //     : ListView.builder(
                      //         shrinkWrap: true,
                      //         physics: NeverScrollableScrollPhysics(),
                      //         itemCount: snapshot.data!.length + 1,
                      //         itemBuilder: (context, index) {
                      //           Map dataAtIndex = {};
                      //           try {
                      //             dataAtIndex = snapshot.data![index];
                      //           } catch (e) {
                      //             // deleteAt deletes that key and value,
                      //             // hence makign it null here., as we still build on the length.
                      //             return Container();
                      //           }
                      //           if (dataAtIndex['type'] == "Income") {
                      //             return incomeTile(
                      //               dataAtIndex['amount'],
                      //               dataAtIndex['note'],
                      //               dataAtIndex['date'],
                      //               index,
                      //             );
                      //           } else {
                      //             return expenseTile(
                      //               dataAtIndex['amount'],
                      //               dataAtIndex['note'],
                      //               dataAtIndex['date'],
                      //               index,
                      //             );
                      //           }
                      //         },
                      //       ),
                      //
                      SizedBox(
                        height: 60.0,
                      ),
                    ],
                  ),
                );
              } else {
                return Text(
                  "Loading...",
                );
              }
            },
          ),
        ),
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

  Widget expenseTile(int value, String note, DateTime date, int index) {
    return InkWell(
      splashColor: Static.PrimaryMaterialColor[400],
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          deleteInfoSnackBar,
        );
      },
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
          context,
          "WARNING",
          "This will delete this record. This action is irreversible. Do you want to continue ?",
        );
        if (answer != null && answer) {
          await dbHelper.deleteData(index);
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(width: 0),
          borderRadius: BorderRadius.circular(10),
          gradient: look != look1
              ? LinearGradient(colors: [
                  Colors.grey.shade900,
                  Colors.grey.shade900,
                ])
              : LinearGradient(colors: [
                  Colors.orange.shade100.withOpacity(0.7),
                  Colors.yellow.shade100.withOpacity(0.8),
                ]),
          boxShadow: [
            BoxShadow(
              color: dark == false ? Colors.grey.shade300 : Colors.black,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_circle_down_outlined,
                          size: 28.0,
                          color: Colors.red.shade900,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        write('Expense', 21, look, true),
                      ],
                    ),

                    //
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: write("${date.day} ${months[date.month - 1]}", 15,
                          look, true),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.euro,
                          size: 24,
                          color: Colors.redAccent.shade700,
                        ),
                        write("- $value", 24, Colors.redAccent.shade700, true),
                      ],
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: write(note, 14, look, true),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget incomeTile(int value, String note, DateTime date, int index) {
    return InkWell(
      splashColor: Static.PrimaryMaterialColor[400],
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          deleteInfoSnackBar,
        );
      },
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
          context,
          "WARNING",
          "This will delete this record. This action is irreversible. Do you want to continue ?",
        );

        if (answer != null && answer) {
          await dbHelper.deleteData(index);
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(width: 0),
          borderRadius: BorderRadius.circular(10),
          gradient: look != look1
              ? LinearGradient(colors: [
                  Colors.grey.shade900,
                  Colors.grey.shade900,
                ])
              : LinearGradient(colors: [
                  Colors.lightGreen.shade100.withOpacity(0.8),
                  Colors.yellow.shade100.withOpacity(0.8),
                ]),
          boxShadow: [
            BoxShadow(
              color: dark == false ? Colors.grey.shade300 : Colors.black,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_circle_up_outlined,
                      size: 28.0,
                      color: look != look1
                          ? Colors.lightGreenAccent.shade400
                          : Colors.greenAccent.shade700,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    write('Credit', 20, look, true),
                  ],
                ),
                //
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: write(
                      "${date.day} ${months[date.month - 1]} ", 15, look, true),
                ),
                //
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.euro,
                      size: 24,
                      color: look != look1
                          ? Colors.lightGreenAccent.shade400
                          : Colors.greenAccent.shade700,
                    ),
                    write(
                        "+ $value",
                        24,
                        look != look1
                            ? Colors.lightGreenAccent.shade400
                            : Colors.greenAccent.shade700,
                        true),
                  ],
                ),
                //
                //
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: write(note, 14, look, true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
