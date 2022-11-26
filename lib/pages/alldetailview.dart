import 'dart:async';

import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  Future<List> details;
  DetailView({Key? key, required this.details}) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EQUITY"),
      ),
      body: FutureBuilder(
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
                              border: Border.all(width: 1, color: Colors.teal)),
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
                                      color: Colors.blue, fontSize: 18),
                                ),
                                subtitle: Text(
                                    'Total: ${int.parse(snapshot.data[index]["equityCash"]) + int.parse(snapshot.data[index]["equityFloat"]) + int.parse(snapshot.data[index]["kcbcoopfloat"])}'),
                                trailing: Text(
                                    'Date: .${snapshot.data[index]["Date"]}'),
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
                                    "FLOAT: ${snapshot.data[index]["equityFloat"]}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "CASH: ${snapshot.data[index]["equityCash"]}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "KCB/COOP: ${snapshot.data[index]["kcbcoopfloat"]}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("DESCRIPTION: ",
                                  style: TextStyle(color: Colors.blue)),
                              Text(snapshot.data[index]["Description"],
                                  maxLines: 4,
                                  style: const TextStyle(color: Colors.black)),
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
    );
  }
}
