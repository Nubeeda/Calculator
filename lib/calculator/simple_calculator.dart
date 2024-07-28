import 'dart:io';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  String equation="0";
  String result="0";
double fontforequ=38.0;
double fontforresult=50;
String expression="";
pressed(String buttonText){
  setState(() {
    if(buttonText == "C"){
      equation = "0";
      result = "0";
    } else if(buttonText == "⌫"){
      equation = equation.substring(0, equation.length - 1);
      if(equation == ""){
        equation = "0";
      }
    } else if(buttonText == "="){
      // Ensure expression is defined from equation
      String expression = equation;
      expression = expression.replaceAll("×", "*");
      expression = expression.replaceAll("÷", "/");
      try{
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        result = "${exp.evaluate(EvaluationType.REAL, cm)}";
      } catch(e){
        result = "Error";  // Set result to "Error"
      }
    } else {
      if(equation == "0"){
        equation = buttonText;
      } else {
        equation = equation + buttonText;
      }
    }
  });

}

  Widget createbutton(String bText,double bHeight,Color bColor){
    return  Container(
        height: MediaQuery.of(context).size.height*.1*bHeight,
        color: bColor,
        child: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0),
                    side:const BorderSide(color: Colors.white,width: 1,style: BorderStyle.solid)
                ),
              ),
            ),
            onPressed: ()=>pressed(bText),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(bText,style:
             const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.normal),),
            )));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        centerTitle: true,
         backgroundColor: Colors.white,
        title:const Text("Calculator",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: Column(children: [
        Container(
          margin:const EdgeInsets.fromLTRB(10, 20, 20, 0),
          alignment: Alignment.centerRight,
          child: Text(equation,style:const TextStyle(fontSize: 38.8,color: Colors.white),),
        ),
       const Divider(color: Colors.white54,),
        Container(
          margin:const EdgeInsets.fromLTRB(10, 20, 20, 0),
          alignment: Alignment.centerRight,
          child: Text(result,style:const TextStyle(fontSize:50.0,color: Colors.white),),
        ),
       const Divider(color: Colors.white54,),
        Expanded(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*.75,
                  child: Table(children: [
                    TableRow(
                      children: [
                      createbutton("C",1, Colors.deepPurple),
                      createbutton("⌫",1, Colors.deepPurple),
                      createbutton("÷",1, Colors.deepPurple),
                      ]
                    ),
                    TableRow(
                        children: [
                          createbutton("9",1, Colors.deepPurple),
                          createbutton("8",1, Colors.deepPurple),
                          createbutton("7",1, Colors.deepPurple),
                        ]
                    ),
                    TableRow(
                        children: [
                          createbutton("6",1, Colors.deepPurple),
                          createbutton("5",1, Colors.deepPurple),
                          createbutton("4",1, Colors.deepPurple),
                        ]
                    ),
                    TableRow(
                        children: [
                          createbutton("3",1, Colors.deepPurple),
                          createbutton("2",1, Colors.deepPurple),
                          createbutton("1",1, Colors.deepPurple),
                        ]
                    ),
                    TableRow(
                        children: [
                          createbutton(".",1, Colors.deepPurple),
                          createbutton("0",1, Colors.deepPurple),
                          createbutton("00",1, Colors.deepPurple),
                        ]
                    ),
                  ],),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        createbutton("×",1, Colors.cyan)
                      ]),
                      TableRow(children: [
                        createbutton(""
                            "+",1, Colors.cyan)
                      ]),
                      TableRow(children: [
                        createbutton("-",1, Colors.cyan)
                      ]),
                      TableRow(children: [
                        createbutton("=",2, Colors.redAccent)
                      ]),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],),
    );
  }
}
