import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'mpesaview.dart';

class Mpesa extends StatefulWidget {
  const Mpesa({Key? key}) : super(key: key);

  @override
  State<Mpesa> createState() => _MpesaState();
}

class _MpesaState extends State<Mpesa> {
  late Future<List> mpesadetails;

  @override
  void initState() {
    super.initState();
    mpesadetails = getMpesa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MPESA"),
      ),
      body: Center(
        child: FutureBuilder(
            future: mpesadetails,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Center(
                    child: Text(
                  "NO DATA",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ));
              } else if (snapshot.hasData) {
                return Container(
                  //padding: const EdgeInsets.all(20),
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.blue)),

                            child: //Column(
                                //children: [
                                ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MpesaDetailView(
                                          details: mpesadetails),
                                    ));
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://mato1mato.000webhostapp.com/baseone/uploads/' +
                                        snapshot.data[index]["imageid"]),
                              ),
                              title: Text(
                                snapshot.data[index]["User"],
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 18),
                              ),
                              subtitle: Text(
                                  'Total: ${int.parse(snapshot.data[index]["mpesaCash"]) + int.parse(snapshot.data[index]["mpesaFloat"]) + int.parse(snapshot.data[index]["mpesaStore"]) + int.parse(snapshot.data[index]["mpesaExpenses"])}'),
                              trailing:
                                  Text('Date: ' + snapshot.data[index]["Date"]),
                            ),
                            //Container(
                            //child: Image.network('https://mato1mato.000webhostapp.com/baseone/uploads/'+snapshot.data[index]["imageid"],fit:BoxFit.fill)),
                            // Column(mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     const SizedBox(height: 10,),
                            //     Text("FLOAT:            "+snapshot.data[index]["equityFloat"]),
                            //     Text("CASH:             "+snapshot.data[index]["equityCash"]),
                            //     Text("KCB/COOP:    "+snapshot.data[index]["kcbcoopfloat"]),

                            //   ],
                            //),
                            // const SizedBox(height: 20,),
                            // const Text("DESCRIPTION: ",style: TextStyle(color: Colors.blue)),
                            // Text(snapshot.data[index]["Description"],maxLines: 4,style: TextStyle(color: Colors.black)),
                            // const SizedBox(height: 20,),
                            //],
                            //),
                          ),
                        );
                      }),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Future<List<dynamic>> getMpesa() async {
    var url = Uri.parse('https://basemanager.herokuapp.com/getmpesa.php');
    var response = await http.post(
      url,
    );
    return jsonDecode(response.body);
  }
}
