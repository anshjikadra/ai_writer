import 'dart:async';

import 'package:ai_writer/dataBase/history_db_model.dart';
import 'package:ai_writer/screen/setting_page.dart';
import 'package:ai_writer/screen/submit_page.dart';
import 'package:ai_writer/screen/write_page.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../dataBase/history_data_file.dart';

int selectIndex=0;





class first_page extends StatefulWidget {
  const first_page({Key? key}) : super(key: key);

  @override
  State<first_page> createState() => _first_pageState();
}

class _first_pageState extends State<first_page> {




  void _onItemTapped(int index) {
    setState(() {
      selectIndex=index;
      print(selectIndex);
    });
  }


  @override
  void initState() {
    super.initState();
    get_data();
  }

  get_data()
  async{
    s_history=await DB.gethistory();
    for(var e in s_history)
      {
        print("questiom:${e.question_data}");
        print("ans:${e.ans_data}");
        print("timw:${e.current_time}");
      }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamGet.stream,
      builder: (context, snapshot) {
        return Scaffold(
          body: body(),

          bottomNavigationBar: BottomNavigationBar(
              items:[
                BottomNavigationBarItem(icon: Icon(Icons.note_alt,),label: 'My Document'),
                BottomNavigationBarItem(icon: Icon(Icons.edit,),label: 'write'),
                BottomNavigationBarItem(icon: Icon(Icons.settings,),label: 'Settings'),
              ],
            currentIndex: selectIndex,
            onTap:_onItemTapped,
            selectedItemColor: Colors.black,

          ),
          backgroundColor:Color(0xFFf4f3fa),
        );
      }
    );
  }



  body()
  {
    if(selectIndex==0)
      {
        return f_page();
      }
    if(selectIndex==1)
      {
        return write_page();
      }
    if(selectIndex==2)
      {
        return setiing_page();
      }
  }

}

class f_page extends StatefulWidget {
  const f_page({Key? key}) : super(key: key);

  @override
  State<f_page> createState() => _f_pageState();
}

class _f_pageState extends State<f_page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "AI Writer PRO",
              style: TextStyle(color: Color(0xFF077A37), fontSize: 20,fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Recents",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: GridView(
                  children: [
                    GestureDetector(
                      onTap: () {

                        selectIndex=1;
                        streamGet.add=selectIndex;

                      },
                      child: DottedBorder(
                        // dashPattern: [8, 4],
                        child: Container(
                            height: 500,
                            width: 250,
                            decoration: BoxDecoration(
                              //border: Border.all(style:BorderStyle. ,color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "image/docment.png",
                                  height: 70,
                                ),
                                Text(
                                  "Create",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            )),
                      ),
                    ),
                    for (var e in s_history)

                      GestureDetector(
                       onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) {
                           return submit_page(question:  e.question_data,answer: e.ans_data,);
                         },));
                       },
                        child: Container(
                          height: 500,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,

                                children: [
                                  Flexible(child: Text("${e.question_data}",style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 15,fontWeight: FontWeight.bold,),maxLines: 1,)),

                                  Text("${e.ans_data}",style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 15),maxLines:6),
                                  Spacer(),
                                  Text("${e.current_time}",style:  TextStyle(fontSize: 15),)
                                ],
                              ),
                            )
                        ),
                      ),
                  ],
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 20)),
            ),
          ],
        ),
      ),
    );
  }
}


// List<String> list = [
//   "",
// ];

StreamGet streamGet = StreamGet();

class StreamGet {
  StreamController streamController = StreamController.broadcast();

  Stream get stream => streamController.stream;

  set add(dynamic event) => streamController.sink.add(event);
}


