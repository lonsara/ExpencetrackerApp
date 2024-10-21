import 'package:expencetracker/Authentication.dart';
import 'package:expencetracker/screens/Bar.dart';
import 'package:expencetracker/screens/barLogic.dart';
import 'package:expencetracker/screens/mainscreen.dart';
import 'package:expencetracker/screens/transactionList.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Module/Transactions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<AllData> masterlist=[];
  List<AllData> get _recentTransactions {
    return masterlist.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }
  void deleteTransaction(String id){
    setState(() {
      masterlist.removeWhere((tx)=>tx.id==id);
    });
  }
  
  void addAllTransaction(String title,double txamount,DateTime txdate){
    setState(() {
      masterlist.add(AllData(id: DateTime.now().toString(), name: title, amount: txamount, date: txdate));
    });
  }
  void showSheet(){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: Transactionlist(addTransaction:addAllTransaction),
          );
        }
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expence Tracker',style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.indigoAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: (){
                showSheet();
              }, child: Icon(Icons.add,size: 30,color: Colors.white,)
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Authentication().logout();
              },
              child:const Icon(Icons.power_settings_new_rounded,size: 30,color: Colors.white,) ,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(_recentTransactions),
            Mainscreen(deleteTransaction,masterlist),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (){
                  Authentication().loginGoogle();
                },
                 child: const Text('SignIn With Google'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
          child: const Icon(Icons.add,size: 30,color: Colors.white,),
          onPressed: (){
          showSheet();
          },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
