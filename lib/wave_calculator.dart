import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'calculator_key.dart';
import 'key_op.dart';
import 'dart:math';


enum Tapping {
  delete , clear ,plus,minus ,multiply, divide,dot,
  one, too,three,four,five,six,seven,eight,nine, zero, period,
  modlus
}

class WaveCalculator extends StatefulWidget {
  WaveCalculator({Key key}): super(key: key);

  @override
  _Calculator createState() {
    return _Calculator();
  }
}

class _Calculator extends State<WaveCalculator>with TickerProviderStateMixin {
  FlareControls flareControl = FlareControls();
  AnimationController animationController;
  Animation animation;
  Tapping selectedButton;
  String value;
  String op;



  _Calculator() {
    value = '';
    op = '';
  }

  void _refresh() {
    setState( () {
    });
  }

  void append(text) {
    value += text;
    _refresh();
  }

  // CE operation
  void clear(String x) {
    op = value = '';
    _refresh();
  }

  void setOperator(text) {
    if (value == '') {
      if (text == '-') {
        value = text;
      }
    }
    else { // replace last operator
      String lastKey = value.substring(value.length-1, value.length);
      if (KeyOp.operators.contains(lastKey)) {
        value = value.substring(0, value.length-1) + text;
      }
      else { // evaluate the operation

        evalExpression();
        //value = '';
        if (text != '=') { // do not print '='
          value += text;
        }
      }
    }
    if (text != '=') {
      op = text;
    }

    _refresh();
  }


  void mC (String g) {

  }

  void evalExpression(){

    if (op == '') {
      return;
    }
    String expression = value;
    var elements = expression.split(op);

    double num1 = double.parse(elements[0]);
    double num2 = double.parse(elements[1]);
    double result = 0.0;

    if (op == '+') {
      result = num1 + num2;
    }
    else if (op == '-') {
      result = num1 - num2;
    }
    else if (op == '*') {
      result = num1 * num2;
    }
    else if (op == '/') {
      result = num1 / num2;
    }
    else if (op == '%') {
      result = num1 % num2;
    }
    else if (op == '/') {
      result = num1 / num2;
    }
    else if (op == '^') {
      result = pow(num1, num2);
    }

    // show integer if the result is integer
    // else should double
    int x = result.toInt();
    if (x.toDouble() == result) {
      value = x.toString();

    }
    else
    {
      value = result.toStringAsPrecision(6);
    }
    setState(() {
      op = '';
      result = 0.0;
    });


  }

  // operations
  void backspace(String x) {
    String tmp = value;
    int len = tmp.length;
    if(KeyOp.modulus == x){

      value = tmp.substring(0, len-1);
      _refresh();

    }}

  String go = "Go" ;
  String ungo = "unGo" ;
  double position = 19;


  void tappAction(String tap){
    if(KeyOp.clear == tap ){
      setState(() {
        selectedButton =Tapping.clear;
      });
    }
  }

  void forwardAction(Tapping tap)  {
    flareControl.play("Go");
    animationController.forward();
    setState(() {
      selectedButton = tap;
    });
  }
  void initState() {
    super.initState();
  //button animation
    animationController = AnimationController(vsync:this,duration: Duration(milliseconds: 600));
    animation =  Tween(begin: 0.0,end: 15.0).animate(animationController)
      ..addListener((){
        setState(() {
        });
      })..addStatusListener((status){
        if(status == AnimationStatus.completed){
          animationController.reverse();
        }else if(status == AnimationStatus.dismissed){
          animationController.reset();
        }
      });
  }

  void anumationTat(AnimationStatus status){
    if(status == AnimationStatus.completed){
      animationController.reverse();
    }else if(status == AnimationStatus.dismissed){
      animationController.forward();
    }

  }

  @override
  Widget build(BuildContext context) {
    double sizedBoxHeight = 10;
    double sizedBoxWidth = 0;

    return Scaffold(
        body:
        Stack(
          children: <Widget>[
            Container(height: 230,
              child: Stack(children: <Widget>[
                // The wave playing + control
                FlareActor('assets/ve.flr',animation: ungo, fit: BoxFit.fill,controller: flareControl,),
                Positioned(
                  top:100,
                  right:position,
                  // the result Title
                  child: Text(value,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 39, color: Colors.deepPurple[600]),
                    softWrap: true,
                  ),
                ),

              ],),

            ),
            Container(child: Column(children: <Widget>[
              Expanded(child:
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                ],
              ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                <Widget>[
                  SizedBox(width: sizedBoxWidth,),
                  GestureDetector(
                      onTap: (){clear(value); forwardAction(Tapping.delete);},
                      child: KeyCool(KeyOp.clear , selectedButton == Tapping.delete ? animation.value :0.0, )),
                  CalculatorKey("MC", mC),
                  GestureDetector(
                      onTap: (){backspace('⌫'); forwardAction(Tapping.modlus);},
                      child: KeyCool(KeyOp.modulus , selectedButton == Tapping.modlus ? animation.value :0.0, )),
                  GestureDetector(
                      onTap: (){setOperator('-'); forwardAction(Tapping.minus);},
                      child: KeyCool(KeyOp.subtract , selectedButton == Tapping.minus ? animation.value :0.0, )),


                  SizedBox(width: sizedBoxWidth,),
                ],
              ),
              SizedBox(height: sizedBoxHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(width: sizedBoxWidth,),
                  GestureDetector(
                      onTap: (){append('7'); forwardAction(Tapping.seven);},
                      child: KeyCool(KeyOp.seven , selectedButton == Tapping.seven ? animation.value :0.0, )),
                  GestureDetector(
                      onTap: (){append('8'); forwardAction(Tapping.eight);},
                      child: KeyCool(KeyOp.eight , selectedButton == Tapping.eight ? animation.value :0.0, )),
                  GestureDetector(
                      onTap: (){append('9'); forwardAction(Tapping.nine);},
                      child: KeyCool(KeyOp.nine , selectedButton == Tapping.nine ? animation.value :0.0, )),
                  GestureDetector(
                      onTap: (){setOperator('*'); forwardAction(Tapping.multiply);},
                      child: KeyCool(KeyOp.multiply , selectedButton == Tapping.multiply ? animation.value :0.0, )),
                  SizedBox(width: sizedBoxWidth,),

                ],
              ),
              SizedBox(height: sizedBoxHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(width: sizedBoxWidth,),
                  GestureDetector(
                      onTap: (){append('4'); forwardAction(Tapping.four);},
                      child: KeyCool(KeyOp.four , selectedButton == Tapping.four ? animation.value :0.0, )),
                  GestureDetector(
                      onTap: (){append('5'); forwardAction(Tapping.five);},
                      child: KeyCool(KeyOp.five , selectedButton == Tapping.five ? animation.value :0.0, )),
                  GestureDetector(
                      onTap: (){append('6'); forwardAction(Tapping.six);},
                      child: KeyCool(KeyOp.six , selectedButton == Tapping.six ? animation.value :0.0, )),
                  GestureDetector(
                      onTap: (){setOperator('/'); forwardAction(Tapping.divide);},
                      child: KeyCool(KeyOp.divide , selectedButton == Tapping.divide ? animation.value :0.0, )),
                  SizedBox(width: sizedBoxWidth,),
                ],
              ),
              SizedBox(height: sizedBoxHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(width: sizedBoxWidth,),
                  GestureDetector(
                      onTap: (){append('1'); forwardAction(Tapping.one);},
                      child: KeyCool(KeyOp.one , selectedButton == Tapping.one ? animation.value :0.0, )),
                  GestureDetector(
                      onTap: (){append('2'); forwardAction(Tapping.too);},
                      child: KeyCool(KeyOp.two , selectedButton == Tapping.too ? animation.value :0.0, )),
                  GestureDetector(
                      onTap: (){append('3'); forwardAction(Tapping.three);},
                      child: KeyCool(KeyOp.three , selectedButton == Tapping.three ? animation.value :0.0, )),
                  GestureDetector(
                      onTap: (){setOperator('+'); forwardAction(Tapping.plus);},
                      child: KeyCool(KeyOp.add , selectedButton == Tapping.plus ? animation.value :0.0, )),
                  SizedBox(width: sizedBoxWidth,),
                ],
              ),
              SizedBox(height: sizedBoxHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                <Widget>[
                  SizedBox(width: sizedBoxWidth,),
                  GestureDetector(
                      onTap: (){append('0'); forwardAction(Tapping.zero);},
                      child: KeyCool(KeyOp.zero , selectedButton == Tapping.zero ? animation.value :0.0, )),
                  SizedBox(width: sizedBoxWidth,),
                  SizedBox(width: sizedBoxWidth,),


                  //SizedBox(width: sizedBoxWidth,),
                  GestureDetector(
                      onTap: (){append('.'); forwardAction(Tapping.period);},
                      child: KeyCool(KeyOp.period , selectedButton == Tapping.period ? animation.value :0.0, )),
                  SizedBox(width: sizedBoxWidth,),
                  SizedBox(width: sizedBoxWidth,),
                  SizedBox(width: 189,),

                  SizedBox(width: sizedBoxWidth,),
                ],
              ),
              SizedBox(height: 44),
            ],),),
            Positioned(bottom: 20,right: 20,
              child:   GestureDetector(onTap: (){
                setOperator('=');
                },
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom :3.0, top :120),
                      child: Material(
                        elevation: 14,shape: CircleBorder(),
                        child: Container(
                            width: 84.0,
                            height: 84.0,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple[100],
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(KeyOp.equals, style: TextStyle(fontSize: 19,color: Colors.grey[700]),
                            )),
                      ),)),
              ),
            ),
          ],

        )
    );
  }
}