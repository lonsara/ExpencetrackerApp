import 'package:expencetracker/Module/Transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Mainscreen extends StatelessWidget {
  Mainscreen(this.deleteTx,this.listdata);
  final Function deleteTx;
  final List<AllData>listdata;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 450,
        child: listdata.isEmpty? Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
             const Text('No Info Added Yet...',style: TextStyle(
               fontSize: 22,
               color: Colors.black
             ),),
             Image.asset('images/img.png',scale: 0.7,),
           ],
         ): ListView.builder(
             itemCount: listdata.length,
             itemBuilder: (context,index){
               return Card(
                 elevation: 5,
                 margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                 child: ListTile(
                   leading: CircleAvatar(
                     radius: 30,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: FittedBox(child: Text('₹ ${listdata[index].amount}')),
                     ),
                   ),
                   title:Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('${listdata[index].name}'),
                       Text('${DateFormat.yMd().format(listdata[index].date)}'),
                     ],
                   ),
                   trailing: InkWell(
                     onTap: (){
                       deleteTx(listdata[index].id);
                     },
                     child: Icon(Icons.delete,color: Colors.red,),
                   ),
                 ),
               );
             }
         ),
      ),
    );
  }
}

