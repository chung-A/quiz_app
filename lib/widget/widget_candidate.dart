import 'package:flutter/material.dart';

class CandidateWidget extends StatefulWidget {
  VoidCallback tap;
  String text;
  int index;
  double width;
  bool answerState;


  CandidateWidget(
      this.tap, this.text, this.index, this.width, this.answerState);


  @override
  _CandidateWidgetState createState() => _CandidateWidgetState();
}

class _CandidateWidgetState extends State<CandidateWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width*0.8,
      height: widget.width*0.1,
      padding: EdgeInsets.fromLTRB(
          widget.width*0.048,
          widget.width*0.024,
          widget.width*0.048,
          widget.width*0.024
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.deepPurple),
        color: widget.answerState?Colors.deepPurple:Colors.white
      ),
      child: InkWell(
        child:Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.width*0.035,
            color:widget.answerState?Colors.white:Colors.black
          ),
        ),
        onTap: (){
          setState(() {
            widget.tap();
            widget.answerState=!widget.answerState;

          });
        },
      ),
    );
  }
}
