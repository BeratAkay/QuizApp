import 'package:flutter/material.dart';
import 'package:quiz_application/views/create_quiz.dart';
import 'package:quiz_application/widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: appBar(context) ,
        backgroundColor: Colors.transparent,
        elevation: 0.0,

      ) ,

      body: Container(
        child: Column(children: [

        ],) ,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=> CreateQuiz()
          ));
        },

      ),
    );
  }
}
