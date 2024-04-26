import 'package:flutter/material.dart';

class UserRecommendationSelection extends StatefulWidget {
  final List<String> diseasesPrediction;

  const UserRecommendationSelection({
    Key? key,
    required this.diseasesPrediction,
  }) : super(key: key);

  @override
  _UserRecommendationSelectionState createState() => _UserRecommendationSelectionState();
}

class _UserRecommendationSelectionState extends State<UserRecommendationSelection> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a Disease"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.diseasesPrediction.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                textColor: index < 6
                    ? (index < 3 ? Colors.red : Colors.amber)
                    : Colors.white70,
                title: Text(widget.diseasesPrediction[index],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                leading: Checkbox(
                  activeColor:index < 6
                      ? (index < 3 ? Colors.red : Colors.amber)
                      : Colors.white70,
                  value: selectedIndex == index,
                  onChanged: (bool? value) {
                    if (value != null) {
                      setState(() {
                        if (value) {
                          selectedIndex = index; // Set this item as selected
                        } else {
                          selectedIndex = null; // Deselect this item
                        }
                      });
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.check),
        onPressed: () {
          if (selectedIndex != null) {
            _showConfirmationDialog(context, widget.diseasesPrediction[selectedIndex!]);
          } else {
            _showErrorDialog(context); // Alert if no item is selected
          }
        },
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String selectedItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Selection Confirmed"),
          content: Text("You have selected: $selectedItem"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("No Selection"),
          content: const Text("Please select an item before confirming."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
