import 'package:flutter/material.dart';

class SalesView extends StatelessWidget {
  final Future<List> futureb;
  const SalesView({Key? key, required this.futureb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SALES"),
      ),
      body: Center(
        child: FutureBuilder(future: futureb, builder: (BuildContext context , AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return Container(//padding: const EdgeInsets.all(20),
                child: ListView.builder(itemCount: snapshot.data.length,itemBuilder: (BuildContext context, int index){
                    return Card(elevation: 5,margin: const EdgeInsets.all(5),
                      child: ListTile(
                              leading: const CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/300'),),
                              title: Text(snapshot.data[index]["User"],style: TextStyle(color: Colors.blue, fontSize: 18),),
                              subtitle: Text('Total Sales: '+snapshot.data[index]["Total"]),
                              trailing: Text('Phones: '+snapshot.data[index]["PhonesSold"]),
                            ),
                    );
                      }),
                     );
                }else{
                  return const Center(child: Text("NO DATA",style: TextStyle(fontSize: 20,color: Colors.red),));
               }
          }),
      )
    );
  }
}