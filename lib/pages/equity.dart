import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'alldetailview.dart';

class Equity extends StatefulWidget {
  const Equity({Key? key}) : super(key: key);

  @override
  State<Equity> createState() => _EquityState();
}

class _EquityState extends State<Equity> {
  late Future<List> equitydetails;

  @override
  void initState() {
    super.initState();
    equitydetails = getEquity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EQUITY"),
      ),
      body: Center(
        child: FutureBuilder(
            future: equitydetails,
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
                                      builder: (context) =>
                                          DetailView(details: equitydetails),
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
                                  'Total: ${int.parse(snapshot.data[index]["equityCash"]) + int.parse(snapshot.data[index]["equityFloat"]) + int.parse(snapshot.data[index]["kcbcoopfloat"])}'),
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

  Future<List<dynamic>> getEquity() async {
    var url = Uri.parse('https://basemanager.herokuapp.com/getequity.php');
    var response = await http.post(
      url,
    );
    return jsonDecode(response.body);
  }
}
