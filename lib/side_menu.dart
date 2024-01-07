import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'App Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            title: Text('BMI Calculator'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/bmi');
            },
          ),
          ListTile(
            title: Text('Movie Search'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/moviepage');
            },
          ),
          ListTile(
            title: Text('Kabar Gempa Terkini'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/kabargempa');
            },
          ),
        ],
      ),
    );
  }
}
