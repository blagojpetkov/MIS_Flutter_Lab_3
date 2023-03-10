import 'package:flutter/material.dart';
import 'package:flutter_lab_3/Model/list_item.dart';
import 'package:nanoid/nanoid.dart';
import 'package:intl/intl.dart';
class NovElement extends StatefulWidget {
  final Function addNewItem;
  NovElement(this.addNewItem);

  @override
  State<StatefulWidget> createState() => NovElementState();
}

class NovElementState extends State<NovElement> {
  final nameController = TextEditingController();
  final dateTimeController = TextEditingController();

  String name = '';
  DateTime? selectedDate = DateTime.now();

  void presentDatePicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now().add(const Duration(days: 50)))
    .then((pickedDate) {
      if(pickedDate == null){
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });

  }

  void submitData() {
    if (nameController.text.isEmpty) {
      return;
    }
    final vnesenoIme = nameController.text;
    final vnesenDatum = DateTime.parse(dateTimeController.text);
    final newItem =
        ListItem(id: nanoid(5), name: vnesenoIme, dateTime: vnesenDatum);
    widget.addNewItem(newItem);
    Navigator.of(context).pop();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Име на предметот"),
            // onChanged: (val) {
            //   name = val;
            // }

            onSubmitted: (_) => submitData(),
          ),
          TextField(
            controller: dateTimeController,
            decoration:
                InputDecoration(labelText: "Датум во формат yyyy-mm-dd hh:mm"),
            keyboardType: TextInputType.datetime,
            // onChanged: (val) {
            //   name = val;
            // }

            onSubmitted: (_) => submitData(),
          ),
          // Container(
          //   height: 50,
          //   child: Row(
          //     children: [
          //       Expanded(child: Text(selectedDate == null ? 'No date chosen' :  DateFormat().add_yMMMd().format(selectedDate!))),
          //       TextButton(child: Text('Choose date', style: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold),), onPressed: presentDatePicker,),
          //     ],
          //   ),
          // ),
          Container(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
            child: Text("Add"),
            onPressed: () => submitData(),
          )
        ],
      ),
    );
  }
}
