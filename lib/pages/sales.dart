import 'dart:convert';

import 'package:admin/util/Saleview.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:intl/intl.dart';

import '../util/textfield.dart';
import 'login.dart';

class Sale extends StatefulWidget {
  const Sale({Key? key}) : super(key: key);

  @override
  State<Sale> createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController mtotal = TextEditingController();
  TextEditingController etotal = TextEditingController();

  final formkey = GlobalKey<FormState>();
  final formkeyb = GlobalKey<FormState>();

  String dat = DateFormat('yyyy-MM-dd KK:mm').format(DateTime.now());
  late Future<List> salesdetails;
  late Future<List> todaysales;
  late Future<List> monthlysales;
  late Future<List> mkopaphones;

  @override
  void initState() {
    super.initState();
    salesdetails = getSales();
    todaysales = getTSales();
    monthlysales = getMsales();
    mkopaphones = getMpsales();
  }

  Future<dynamic> addUser(
      String user, String password, String mfloat, String efloat) async {
    var url = Uri.parse('https://basemanager.herokuapp.com/adduser.php');
    var response = await http.post(url, body: {
      "user": user,
      "password": password,
      "efloat": efloat,
      "mfloat": mfloat
    });

    var data = json.decode(response.body);
    if (data == "success") {
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        showCloseIcon: true,
        title: 'Success',
        desc: 'User added Successful',
        btnOkOnPress: () {},
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          //debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else if (data == "error") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'DB Error',
        desc: 'Error Occured.. Please try Again',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    }
  }

  Future<dynamic> deleteUser(
    String user,
  ) async {
    var url = Uri.parse('https://basemanager.herokuapp.com/deleteuser.php');
    var response = await http.post(url, body: {
      "user": user,
    });

    var data = json.decode(response.body);
    if (data == "success") {
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        showCloseIcon: true,
        title: 'Success',
        desc: 'User deleted Successful',
        btnOkOnPress: () {},
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          //debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else if (data == "error") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'DB Error',
        desc: 'Error Occured.. Please try Again',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    }
  }

  Future<dynamic> setFloat(String user, String efloat, String mfloat) async {
    var url = Uri.parse('https://basemanager.herokuapp.com/setfloat.php');
    var response = await http
        .post(url, body: {"user": user, "efloat": efloat, "mfloat": mfloat});

    var data = json.decode(response.body);
    if (data == "success") {
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        showCloseIcon: true,
        title: 'Success',
        desc: 'User updated Successful',
        btnOkOnPress: () {},
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          //debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else if (data == "error") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'DB Error',
        desc: 'Error Occured.. Please try Again',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    }
  }

  Future<dynamic> resetData() async {
    var url = Uri.parse('https://basemanager.herokuapp.com/resetdata.php');
    var response = await http.post(url, body: {});

    var data = json.decode(response.body);
    if (data == "success") {
      AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        showCloseIcon: true,
        title: 'Success',
        desc: 'Data reset Successful',
        btnOkOnPress: () {},
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          //debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } else if (data == "error") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'DB Error',
        desc: 'Error Occured.. Please try Again',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: salesdetails,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text(
                "NO DATA",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ));
            }
            //check for data in sanpshot
            else if (snapshot.hasData) {
              return Container(
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          //   gradient: LinearGradient(colors: [
                          //    Color.fromRGBO(255, 248, 134,1),
                          //   Color.fromARGB(240, 114, 182,1)
                          // ])
                          color: Colors.teal),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 45,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'HOME',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  dat,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('LOGOUT'),
                                          content: const Text(
                                              'Are you sure you want to logout?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Login(),
                                                    ));
                                                Fluttertoast.showToast(
                                                    msg: "LOGOUT SUCCESSFUL");
                                              },
                                              child: const Text('OK'),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, 'Cancel');
                                                },
                                                child: const Text("Cancel"))
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.logout),
                                    tooltip: 'Logout')
                              ],
                            ),
                          ),
                          const Divider(
                            height: 5,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 2 / 9,
                      decoration: const BoxDecoration(
                          //
                          color: Colors.teal,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      child: Column(
                        children: [
                          const ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text(
                              "ADMIN",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text('0718901248',
                                style: TextStyle(fontSize: 16)),
                          ),
                          Container(
                            child: Column(
                              children: [
                                const Text('MONTHLY SALES',
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                                const Divider(height: 2),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Text('PHONES',
                                        style: TextStyle(fontSize: 16)),
                                    Text('MKOPA',
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                    Text('TOTAL',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(snapshot.data[0]["nphones"],
                                          style: const TextStyle(
                                            fontSize: 16,
                                          )),
                                      Text(snapshot.data[0]["mphones"],
                                          style: const TextStyle(
                                            fontSize: 16,
                                          )),
                                      Text(snapshot.data[0]["total"],
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        // const Padding(padding: EdgeInsets.all(1),
                        // child: Center(child: Text("MANAGEMENT",style: TextStyle(color: Colors.blue,fontSize: 22),)),
                        // ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showDialog<String>(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('ADD USER'),
                                          content: const Text(
                                              'Please provide user details'),
                                          actions: <Widget>[
                                            Form(
                                                key: formkey,
                                                child: Column(
                                                  children: [
                                                    GetTextField(
                                                        keytype:
                                                            TextInputType.text,
                                                        Controller: name,
                                                        hintname: "username",
                                                        icon: Icons.person,
                                                        isObsecureText: false,
                                                        label: "Name"),
                                                    const SizedBox(height: 15),
                                                    GetTextField(
                                                        keytype:
                                                            TextInputType.text,
                                                        Controller: pass,
                                                        hintname: "password",
                                                        icon: Icons.person,
                                                        isObsecureText: false,
                                                        label: "Password"),
                                                    const SizedBox(height: 15),
                                                    GetTextField(
                                                        keytype:
                                                            TextInputType.text,
                                                        Controller: mtotal,
                                                        hintname: "Mpesa Total",
                                                        icon: Icons.person,
                                                        isObsecureText: false,
                                                        label: "Mpesa Total"),
                                                    const SizedBox(height: 15),
                                                    GetTextField(
                                                        keytype:
                                                            TextInputType.text,
                                                        Controller: etotal,
                                                        hintname:
                                                            "Equity Total",
                                                        icon: Icons.person,
                                                        isObsecureText: false,
                                                        label: "Equity Total"),
                                                  ],
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    if (formkey.currentState!
                                                        .validate()) {
                                                      addUser(
                                                          name.text,
                                                          pass.text,
                                                          mtotal.text,
                                                          etotal.text);
                                                      formkey.currentState!
                                                          .reset();

                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, 'Cancel');
                                                    },
                                                    child: const Text("Cancel"))
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                          color: Colors.green[400],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1 /
                                              4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              1 /
                                              8,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.person, size: 35),
                                              Text(
                                                "Add User",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog<String>(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text(
                                            'SET FLOAT',
                                          ),
                                          content: const Text(
                                              'Please provide user details'),
                                          actions: <Widget>[
                                            Form(
                                                key: formkeyb,
                                                child: Column(
                                                  children: [
                                                    GetTextField(
                                                        keytype:
                                                            TextInputType.text,
                                                        Controller: name,
                                                        hintname: "username",
                                                        icon: Icons.person,
                                                        isObsecureText: false,
                                                        label: "Name"),
                                                    const SizedBox(height: 15),
                                                    GetTextField(
                                                        keytype:
                                                            TextInputType.text,
                                                        Controller: mtotal,
                                                        hintname: "Mpesa Total",
                                                        icon: Icons.person,
                                                        isObsecureText: false,
                                                        label: "Mpesa Total"),
                                                    const SizedBox(height: 15),
                                                    GetTextField(
                                                        keytype:
                                                            TextInputType.text,
                                                        Controller: etotal,
                                                        hintname:
                                                            "Equity Total",
                                                        icon: Icons.person,
                                                        isObsecureText: false,
                                                        label: "Equity Total"),
                                                  ],
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    if (formkeyb.currentState!
                                                        .validate()) {
                                                      setFloat(
                                                          name.text,
                                                          mtotal.text,
                                                          etotal.text);
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, 'Cancel');
                                                    },
                                                    child: const Text("Cancel"))
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                          color: Colors.green[400],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1 /
                                              4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              1 /
                                              8,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.person, size: 35),
                                              Text("Set Float",
                                                  style: TextStyle(
                                                      color: Colors.white))
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 30),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SalesView(futureb: todaysales),
                                          ));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                          color: Colors.teal[300],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1 /
                                              4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              1 /
                                              8,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.phone_iphone,
                                                  size: 35),
                                              Text("Today Sales",
                                                  style: TextStyle(
                                                      color: Colors.white))
                                            ],
                                          )),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SalesView(
                                                futureb: monthlysales),
                                          ));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                          color: Colors.teal[300],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1 /
                                              4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              1 /
                                              8,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                  Icons.phone_android_outlined),
                                              Text("Monthly Sales",
                                                  style: TextStyle(
                                                      color: Colors.white))
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              ),

                              const Divider(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showDialog<String>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('DELETE USER'),
                                          content: const Text(
                                              'Please provide user details'),
                                          actions: <Widget>[
                                            GetTextField(
                                                keytype: TextInputType.text,
                                                Controller: name,
                                                hintname: "Username",
                                                icon: Icons.person,
                                                isObsecureText: false,
                                                label: "Username"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    deleteUser(name.text);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, 'Cancel');
                                                    },
                                                    child: const Text("Cancel"))
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                          color: Colors.red[200],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1 /
                                              4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              1 /
                                              8,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.delete, size: 35),
                                              Text("Delete User",
                                                  style: TextStyle(
                                                      color: Colors.white))
                                            ],
                                          )),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog<String>(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('RESET DATA'),
                                          content: const Text(
                                              'Are you sure to reset data?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                resetData();
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, 'Cancel');
                                                },
                                                child: const Text("Cancel"))
                                          ],
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                          color: Colors.red[200],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1 /
                                              4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              1 /
                                              8,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.delete, size: 35),
                                              Text("Reset Data",
                                                  style: TextStyle(
                                                      color: Colors.white))
                                            ],
                                          )),
                                    ),
                                  )
                                ],
                              ),
                              // const Divider(height: 30),
                              // Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //     children: [

                              //       GestureDetector(
                              //         onTap: (){
                              //           Navigator.push(context, MaterialPageRoute(builder: (context) => SalesView(futureb: mkopaphones),));

                              //         },
                              //         child: ClipRRect(borderRadius: BorderRadius.circular(20),
                              //           child: Container(color: Colors.green[300],width: MediaQuery.of(context).size.width*1/3,height:MediaQuery.of(context).size.height*1/7,
                              //             child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              //               children: const[
                              //                 Icon(Icons.phone_android_outlined,size: 35),
                              //                 Text("Mkopa phones")
                              //               ],
                              //             )
                              //           ),
                              //         ),),
                              //     ],
                              //   ),
                            ],
                          ),
                        ),

                        ///const SizedBox(height: 20,),
                      ],
                    )),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text(
                "NO DATA",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<List<dynamic>> getSales() async {
    var url = Uri.parse('https://basemanager.herokuapp.com/getSales.php');
    var response = await http.post(url);
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> getTSales() async {
    var url =
        Uri.parse('https://basemanager.herokuapp.com/baseone/getTsales.php');
    var response = await http.post(url);
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> getMsales() async {
    var url = Uri.parse('https://basemanager.herokuapp.com/getMsales.php');
    var response = await http.post(
      url,
    );
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> getMpsales() async {
    var url = Uri.parse('https://basemanager.herokuapp.com/getMpsales.php');
    var response = await http.post(
      url,
    );
    return jsonDecode(response.body);
  }
}
