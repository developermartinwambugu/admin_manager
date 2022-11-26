import 'dart:async';

import 'package:flutter/material.dart';

class MpesaDetailView extends StatefulWidget {
  Future<List> details;
  MpesaDetailView({Key? key, required this.details}) : super(key: key);

  @override
  State<MpesaDetailView> createState() => _MpesaDetailViewState();
}

class _MpesaDetailViewState extends State<MpesaDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MPESA"),
      ),
      body: Center(
        child: FutureBuilder(
            future: widget.details,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
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
                                    Border.all(width: 1, color: Colors.teal)),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://mato1mato.000webhostapp.com/baseone/uploads/' +
                                            snapshot.data[index]["imageid"]),
                                  ),
                                  title: Text(
                                    snapshot.data[index]["User"],
                                    style: const TextStyle(
                                        color: Colors.teal, fontSize: 18),
                                  ),
                                  subtitle: Text(
                                      'Total: ${int.parse(snapshot.data[index]["mpesaCash"]) + int.parse(snapshot.data[index]["mpesaFloat"]) + int.parse(snapshot.data[index]["mpesaStore"]) + int.parse(snapshot.data[index]["mpesaExpenses"])}'),
                                  trailing: Text(
                                      'Date: ' + snapshot.data[index]["Date"]),
                                ),
                                Container(
                                    child: Image.network(
                                        'https://mato1mato.000webhostapp.com/baseone/uploads/${snapshot.data[index]["imageid"]}',
                                        fit: BoxFit.fill)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Float: ${snapshot.data[index]["mpesaFloat"]}",
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "Cash:  ${snapshot.data[index]["mpesaCash"]}",
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "Store: ${snapshot.data[index]["mpesaStore"]}",
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "Expense: ${snapshot.data[index]["mpesaExpenses"]}",
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text("DESCRIPTION: ",
                                    style: TextStyle(color: Colors.teal)),
                                Text(snapshot.data[index]["Description"],
                                    maxLines: 4,
                                    style:
                                        const TextStyle(color: Colors.black)),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
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
      ),
    );
  }
}
