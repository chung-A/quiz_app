import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:quiz_app/model/model_quiz.dart';
import 'package:quiz_app/widget/widget_candidate.dart';

class QuizScreen extends StatefulWidget {
  List<Quiz> quizs;
  QuizScreen(this.quizs);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<int> answers=[-1,-1,-1];
  List<bool> answerState=[false,false,false,false];
  int currentIndex=0;
  SwiperController controller=SwiperController();

  @override
  Widget build(BuildContext context) {
    Size screenSize=MediaQuery.of(context).size;
    double width=screenSize.width;
    double height=screenSize.height;
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.deepPurple),
            color: Colors.white
          ),
          width: width*0.85,
          height: height*0.5,
          child: Swiper(
            controller: controller,
            physics: NeverScrollableScrollPhysics(),
            loop:false,
            itemCount: widget.quizs.length,
            itemBuilder: (BuildContext context, int index ){
              return buildQuizCard(widget.quizs[index],width,height);
            },
          ),
        ),
      ),
    ));
  }

  Widget buildQuizCard(Quiz quiz,double width,double height){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color:Colors.white)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, width*0.024, 0, width*0.024),
            child: Text(
              "Q: "+(currentIndex+1).toString()+'.',
              style: TextStyle(
                fontSize: width*0.06,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            width: width*0.8,
            padding: EdgeInsets.only(top:width*0.012),
            child: AutoSizeText(
                quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: width*0.048,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Expanded(child: Container()),
          Column(children:
            buildCandidates(width, quiz)
          ,),
          Container(
            padding: EdgeInsets.all(width*0.024),
            child: Center(
              child: ButtonTheme(
                minWidth: width*0.024,
                height: height*0.05,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: RaisedButton(
                  child: currentIndex==widget.quizs.length-1?Text("결과보기"):Text("다음문제"),
                  textColor: Colors.white,
                  color: Colors.deepPurple,
                  onPressed: answers[currentIndex]==-1?null:(){
                    controller.next();

                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildCandidates(double width,Quiz quiz){
    List<Widget> children=[]; 
    for(int i=0;i<4;i++) {
      children.add(
        CandidateWidget(
            (){setState(() {
               for(int j=0;j<4;j++){
                 if(j==i){
                   answerState[j]=true;
                   answers[currentIndex]=j;
                 }else{
                   answerState[j]=false;
                 }
               }
              });
            }, quiz.candidates[i], i, width, answerState[i])
      );

      children.add(
        Padding(
          padding: EdgeInsets.all(width*0.024),
        )
      );

    }
    return children;
  }
}
