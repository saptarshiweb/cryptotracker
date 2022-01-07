import 'package:expense/controllers/db_helper.dart';
import 'package:expense/pages/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //

  DbHelper dbHelper = DbHelper();

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade900,
        title: Row(
          children: [
            write('Settings  ', 24, Colors.white, true),
            Icon(
              Icons.settings,
              color: Colors.white,
              size: 28,
            )
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(
          12.0,
        ),
        children: [
          ListTile(
            onTap: () async {
              bool answer = await showConfirmDialog(context, "Warning",
                  "This is irreversible. Your entire data will be Lost");
              if (answer) {
                await dbHelper.cleanData();
                Navigator.of(context).pop();
              }
            },
            tileColor: Colors.black,
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 20.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            title: Text(
              "Clean Data",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
                fontFamily: 'lato',
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              "This is irreversible",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'lato',
                fontSize: 14,
              ),
            ),
            trailing: Icon(
              Icons.delete_forever,
              size: 32.0,
              color: Colors.redAccent.shade700,
            ),
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          //
          ListTile(
            onTap: () async {
              String nameEditing = "";
              String? name = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.grey[300],
                  title: Text(
                    "Enter new name",
                  ),
                  content: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Your Name",
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      maxLength: 12,
                      onChanged: (val) {
                        nameEditing = val;
                      },
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(nameEditing);
                      },
                      child: Text(
                        "OK",
                      ),
                    ),
                  ],
                ),
              );
              //
              if (name != null && name.isNotEmpty) {
                DbHelper dbHelper = DbHelper();
                await dbHelper.addName(name);
              }
            },
            tileColor: Colors.black,
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 20.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            title: Text(
              "Change Name",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
                fontFamily: 'lato',
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              "Welcome {newname}",
              style: TextStyle(
                fontFamily: 'lato',
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.change_circle,
              size: 32.0,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),

          ListTile(
            onTap: () async {},
            tileColor: Colors.black,
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 20.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            title: Text(
              "App Credits ",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
                fontFamily: 'lato',
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              "Developed by Saptarshi Mandal\nKGEC IT 2nd Year\nDSC KGEC",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'lato',
                fontSize: 14,
              ),
            ),
            trailing: Icon(
              Icons.credit_score_outlined,
              size: 32.0,
              color: Colors.yellowAccent.shade700,
            ),
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
