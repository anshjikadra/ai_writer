import 'package:ai_writer/screen/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

class submit_page extends StatefulWidget {
  String question,answer;
  submit_page({required this.question,required this.answer});

  @override
  State<submit_page> createState() => _submit_pageState();
}

class _submit_pageState extends State<submit_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(

            children: [
              GestureDetector(
                onTap: () {

                  Navigator.pop(context);
                },
                child: Row(

                  children: [

                    Icon(Icons.arrow_back_ios,color: Color(0xFF077A37),size: 20,),
                    Align(alignment: Alignment.topLeft,child: Text("Back",style: TextStyle(color:Color(0xFF077A37),fontSize: 20),)),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  flex: 7,
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Question: ${widget.question}",style: TextStyle(fontSize: 18)),
                            SizedBox(height: 15,),
                            Text("Answer: ${widget.answer}",style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        IconButton(onPressed: () {


                          Clipboard.setData(ClipboardData(text: widget.answer));
                          Fluttertoast.showToast(
                              msg: "Copy Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black38,
                              textColor: Colors.white,
                              fontSize: 16.0);


                        }, icon:Icon(Icons.copy_outlined,size: 30,)),
                        
                        GestureDetector(
                          onTap: () {
                            Share.share("Question: ${widget.question}\n\nAnswer:${widget.answer}");
                            setState(() {

                            });
                          },
                          child: Container(
                            height: 60,
                            width: 210,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF077A37),
                            ),
                            child: Center(child: Text("Share",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),backgroundColor: Color(0xFFf4f3fa),
    );
  }
}
