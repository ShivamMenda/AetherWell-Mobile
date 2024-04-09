import 'package:flutter/material.dart';

class CustomBottomNavigaton extends StatefulWidget {
  final Function(int) onIndexChanged;
  final int initialIndex;

  CustomBottomNavigaton({Key? key, required this.onIndexChanged, this.initialIndex = 0})
      : super(key: key);

  @override
  _CustomBottomNavigatonState createState() => _CustomBottomNavigatonState();
}

class _CustomBottomNavigatonState extends State<CustomBottomNavigaton> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              _onItemTapped(0);
            },
            icon: Icon(Icons.home_filled),
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              _onItemTapped(1);
            },
            icon: Icon(Icons.receipt_outlined),
          ),
          label: "Patient's Details",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              _onItemTapped(2);
            },
            icon: Icon(Icons.date_range_outlined),
          ),
          label: "Appointment",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              _onItemTapped(3);
            },
            icon: Icon(Icons.person),
          ),
          label: "Profile",
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.white70,
      unselectedLabelStyle: TextStyle(color: Colors.blueGrey),
      unselectedItemColor: Colors.blueGrey,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    widget.onIndexChanged(index);
  }
}

