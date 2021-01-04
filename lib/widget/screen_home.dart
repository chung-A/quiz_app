import 'package:flutter/material.dart';
import 'package:quiz_app/model/api_adapter.dart';
import 'package:quiz_app/model/model_quiz.dart';
import 'package:quiz_app/screen/screen_quiz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey=GlobalKey<ScaffoldState>();

  List<Quiz> quizs=[
    Quiz.fromMap({
      'title':'test',
      'candidates':['a','b','c','d'],
      'answer':1
    }),
    Quiz.fromMap({
      'title':'test',
      'candidates':['a','b','c','d'],
      'answer':1
    }),
    Quiz.fromMap({
      'title':'test',
      'candidates':['a','b','c','d'],
      'answer':1
    })
  ];

  bool isLoading=false;

  fetchQuizs() async{
    setState(() {
      isLoading=true;
    });
    final response=await http.get('http://localhost:8080/home');
    print(response);
    if(response.statusCode==200) {
      setState(() {
        print('ddddd');
        var decode = utf8.decode(response.bodyBytes);
        isLoading=false;
        // parseQuizs(utf8.decode(response.bodyBytes));
      });
    }
    else{
      throw Exception("data not loading");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize=MediaQuery.of(context).size;
    double width=screenSize.width;
    double height = screenSize.height;

    return SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text('내 퀴즈 앱'),
            backgroundColor: Colors.deepPurple,
            leading: Container(),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Image.asset('images/quiz.jpeg',width: width*0.8,)
              ),
              Padding(
                  padding: EdgeInsets.all(width*0.024)
              ),
              Text(
                "플러터 퀴즈 앱",
                style: TextStyle(
                  fontSize: width*0.065,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "퀴즈를 풀기 전 안내사항입니다. \n 꼼꼼히 읽고 퀴즈풀기를 눌러주세요"
              ),
              Padding(padding: EdgeInsets.all(width*0.048)),
              _buildStep(width, "1. 랜덤으로 나오는 퀴즈를 풀어주세요"),
              _buildStep(width, "2. 문제를 잘 읽고 체크하고 다음으로 버튼을 눌러주세요"),
              _buildStep(width, "3. 만점을 향해 도전해 보세요"),
              Container(
                padding: EdgeInsets.only(bottom: width*0.036),
                child: Center(
                  child: ButtonTheme(
                    minWidth: width*0.8,
                    height: height*0.05,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: RaisedButton(
                      child:Text(
                        "지금 퀴즈풀기",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.deepPurple,
                      onPressed: (){
                        scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Row(
                            children: <Widget>[
                              CircularProgressIndicator(),
                              Padding(
                                padding: EdgeInsets.only(left: width*0.036),
                              )
                            ],
                          ))
                        );
                        print('통신 시작합니다');
                        fetchQuizs().whenComplete((){
                          return Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>QuizScreen(quizs)
                          ));
                        });
                      },
                    ),
                  )
                ),
              )
            ],
          ),
        )
    );
  }

  Widget _buildStep(double width,String title){
    return Container(
      padding: EdgeInsets.fromLTRB(
          width*0.048,
          width*0.024,
          width*0.048,
          width*0.024),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.check_box,size:width*0.04),
          Text(title)
        ],
      ),
    );
  }
}
