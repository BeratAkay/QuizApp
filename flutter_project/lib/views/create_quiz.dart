import 'package:flutter/material.dart';
import 'package:quiz_application/services/database.dart';
import 'package:quiz_application/views/addquestion.dart';
import 'package:random_string/random_string.dart';

import '../widgets/widgets.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  DatabaseService databaseService=new DatabaseService();
  final formKey=GlobalKey<FormState>();
  late String quizImg,quizTitle,quizDescription,quizId;
  bool _isLoading=false;

  createQuiz() async{

    if(formKey.currentState!.validate()){

      setState(() {
        _isLoading=true;
      });
      quizId=randomAlphaNumeric(16);


      Map<String, String> quizData = {
        "quizId": quizId,
        "quizImgUrl" : quizImg,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDescription
      };
     await databaseService.addQuizData(quizData, quizId).then((value) {
        setState(() {
          _isLoading=false;
        });
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => AddQuestions()
          ));

      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: appBar(context) ,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,

      ) ,

      body: _isLoading ? Container(
        child: Center(child: CircularProgressIndicator(),),
      ): Form(
        key: formKey,

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24) ,
          child: Column(children: [
            TextFormField(
              validator: (val) =>
              val!.isEmpty ? "Resmi yükleyin":null,
              decoration: const InputDecoration(
                hintText: "Quiz Resim",
              ),

              onChanged: (val){
                quizImg=val;
              },
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (val) => val!.isEmpty ?"Quiz Baslık": null,
              decoration: const InputDecoration(
                hintText: "Quiz Başlık",
              ),

              onChanged: (val){
                quizTitle=val;
              },
            ),
            SizedBox(height: 6,),
            TextFormField(
              validator: (val) => val!.isEmpty ? "Açıklama yazın": null,
              decoration: const InputDecoration(
                hintText: "Quiz Açıklama",
              ),

              onChanged: (val){
                quizDescription=val;
              },
            ),
            const Spacer(),
            
            GestureDetector(
              onTap: (){
                createQuiz();
              },
                child: blueButton(
                    context: context, label: "Quiz Oluştur")),
            const SizedBox(height: 60,),

          ],),
        ),
      ),
    );
  }
}
