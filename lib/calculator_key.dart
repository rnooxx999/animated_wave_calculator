import 'package:flutter/material.dart';
import 'key_op.dart';

class CalculatorKey extends StatelessWidget {
  final String keyop;
  final Function(String) callback;
  const CalculatorKey(this.keyop, this.callback );
  
  @override
  Widget build(BuildContext context) {
    double buttonHeight = MediaQuery.of(context).size.height / 12;
    double roundedEdges =30;
    Color buttonColor;

    if (keyop == KeyOp.equals) {
      buttonColor = Colors.lightGreen[800];
    }
    else {
      buttonColor = Colors.grey[110];
    }

    return GestureDetector(
      onTap: (){
      callback(keyop);
      },
        child: Container(
                width: 63,
                height: 63,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Color.fromRGBO(128,0,128,0.2) ,
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  )]
                ),
                child: Center(
                child :Text( keyop, style: TextStyle(fontSize: 24,color: Colors.deepPurple[900].withOpacity(0.5)),),),
              ),
      );















//
//
//    Container(
//      child: RaisedButton(
//        color: buttonColor,
//        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(roundedEdges)),
//        child:
//        Text(keyop,
//                style: Theme.of(context).textTheme.display1.copyWith(color: Colors.black)
//                ),
//        onPressed: ()
//                {
//                  callback(keyop);
//                },
//        ),
//        // elevation: 4,
//        height: buttonHeight,
//    );
  }
}


class KeyCool extends StatelessWidget {
  final String keyop;
  final double tap;
  const KeyCool(this.keyop,  this.tap);

  @override
  Widget build(BuildContext context) {
    double buttonHeight = MediaQuery.of(context).size.height / 12;
    double roundedEdges =30;
    Color buttonColor;

    if (keyop == KeyOp.equals) {
      buttonColor = Colors.lightGreen[800];
    }
    else {
      buttonColor = Colors.grey[110];
    }

    return Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Color.fromRGBO(128,0,128,0.2) ,
                    blurRadius: tap,
                    spreadRadius: tap,
                  )]
                ),
                child: Center(
                child :Text( keyop, style: TextStyle(fontSize: 24, color: Colors.deepPurple[900].withOpacity(0.5)),),),

      );}}