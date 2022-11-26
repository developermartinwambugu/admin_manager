import 'package:admin/pages/equity.dart';
import 'package:admin/pages/mpesa.dart';
import 'package:admin/pages/sales.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  String user;
  Home({Key? key, required this.user}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
} 

class _HomeState extends State<Home> {

 int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[  
    Sale(),
    Mpesa(),
    Equity()
  ];  

  void _onItemTapped(int index) {  
      setState(() {
        _selectedIndex=index;
      });
    } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(  
        items: const <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.home),  
            label: "HOME"  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.wallet),  
            label: "MPESA"
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.person),  
            label: "EQUITY" 
          ),  
        ],  
        type: BottomNavigationBarType.fixed,  
        selectedItemColor: Colors.green,   
        onTap: _onItemTapped,  
        elevation: 5 ,
        currentIndex: _selectedIndex,
      ),  
    ); 
  }
}