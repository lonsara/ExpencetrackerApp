import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Transactionlist extends StatefulWidget {
  final Function addTransaction;
  Transactionlist({super.key,required this.addTransaction});

  State<Transactionlist> createState() => _TransactionlistState();
}

class _TransactionlistState extends State<Transactionlist> {
  final _titleControler=TextEditingController();
  final _amountControler=TextEditingController();

  DateTime? isSelected;

  void _submittedData() {
    if (_amountControler.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleControler.text;
    final enteredAmount = double.parse(_amountControler.text);

    //Logic for not filling Negative values and empty title and amount
    if (enteredTitle.isEmpty || enteredAmount <= 0 || isSelected == null) {
      return;
    }
    ///Passing Data to State Object.
    widget.addTransaction(
      enteredTitle,
      enteredAmount,
      isSelected,
    );

    Navigator.of(context).pop();
  }
  void datePicker(){
    showDatePicker(
        context: context,
        firstDate: DateTime(2021),
        lastDate: DateTime.now()
    ).then((pikedDate){
      if(pikedDate==null){
        return;
      }
      setState(() {
        isSelected=pikedDate;
      });
    });
  }

  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(height: 20,),
          TextField(
            controller: _titleControler,
            decoration: InputDecoration(
              label: Text('Title'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.indigoAccent,
                  width: 1,
                )
              )
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            controller: _amountControler,
            decoration: InputDecoration(
              label: Text('Amount'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.indigoAccent,
                      width: 1,
                    )
                )
            ),
          ),
          Container(
            height: 50,
            child: Row(
              children: [
                SizedBox(height: 20,),
                Expanded(
                  child: Text(isSelected==null?
                  'No Date Selected':
                      'Picked date: ${DateFormat.yMd().format(isSelected!)}'
                  ),
                ),
                TextButton(
                    onPressed: (){
                      datePicker();
                    },
                    child: const Text('Select Date:- ',style: TextStyle(
                      color: Colors.indigoAccent,
                    ),),
                )
              ],
            ),
          ),
          ElevatedButton(
              onPressed: (){
                _submittedData();
              },
              child: Text('Add Transaction'),
          )
        ],
      ),
    );
  }
}
