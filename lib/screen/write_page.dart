import 'dart:convert';

import 'package:ai_writer/dataBase/history_data_file.dart';
import 'package:ai_writer/dataBase/history_db_model.dart';
import 'package:ai_writer/screen/submit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'first_page.dart';

String basUrL = 'https://drawing-how-to-draw.com/chatgpt/api/chat_gpt';



DateTime dt = DateTime.now();

class write_page extends StatefulWidget {


  const write_page({Key? key}) : super(key: key);

  @override
  State<write_page> createState() => _write_pageState();
}

class _write_pageState extends State<write_page> {

  double sliderValOne = 0;
  double sliderValTwo = 0;
  TextEditingController myText = TextEditingController();
  bool isLoding = false;


  // String time= "${dt.day}-${dt.month}-${dt.hour}:${dt.minute}";


  int word=200;





  Future call_api() async {
    setState(() {
      isLoding = true;
    });

    var request = http.MultipartRequest('POST',
        Uri.parse('https://drawing-how-to-draw.com/chatgpt/api/chat_gpt'));

    request.headers['Authorization'] = 'Bearer rZ79vbE6Gq1RU8kvVZKx9IvNo21hSdWkJEde5iYIGN3l0fycTawUXqjY92Yu';
    // print("-------------------login api ${'http://192.168.1.34/vidhi/laravel/dayworkout/api/user_login'}");
    print(
        "-------------------login api ${'https://drawing-how-to-draw.com/chatgpt/api/chat_gpt'}");

    request.fields.addAll({
      'q': myText.text,
      'app_id': '1',
    });

    print("---------------------------quetion ${myText.text}");
    print("---------------------------app_id");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      print("==========login $jsonResponse========");
      print("=========${jsonResponse['ans']}========");

      // String date='${dt.day}-${dt.month} ${dt.hour}:${dt.minute}';
      String formattedDate = DateFormat('dd-MM HH:MM').format(dt);

      String ans=jsonResponse['ans'];
      if (ans.startsWith("\n")){
        ans = ans.substring(1, ans.length);
        if (ans.startsWith("\n")){
          ans = ans.substring(1, ans.length);
        }
      }

      DB.save(H_data(question_data: myText.text,ans_data: ans,current_time: formattedDate));
      setState(() {});

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => submit_page(
                  question: myText.text,
                  answer: ans,
                )),
      );

      if (jsonResponse['success'] == "1") {
        //SharedPreferences sp = await SharedPreferences.getInstance();
        // sp.setString("user_id", jsonResponse['data']['id'].toString());

        // print("LOGIN_SCREEN_USER_ID_SET------------${sp.getString("user_id")}");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            // content: Text('Invalid Mobile Number or Password!'),
            content: Text("User Login Successful"),
          ),
        );

        // loading(false);
        setState(() {
          isLoding = false;
        });
      }
      else if (jsonResponse['success'] == "0") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // content: Text('Invalid Mobile Number or Password!'),
            content: Text(jsonResponse['message'].toString()),
          ),
        );
        setState(() {
          isLoding = false;
        });
      }
      else if (jsonResponse['code'] == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid Mobile Number or Password!'),
          ),
        );
        setState(() {
          isLoding = false;
        });

        // box('Invalid Mobile Number or Password!');
        // loading(false);
        // const CircularProgressIndicator();
      }
    } else {
      setState(() {
        isLoding = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.reasonPhrase.toString()),
        ),
      );
      print(response.reasonPhrase);
    }
  }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "AI Writer",
                    style: TextStyle(
                        color: Color(0xFF077A37),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Instructions",
                      style: TextStyle(color: Colors.grey, fontSize: 17),
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: myText,
                      maxLines: 50000000,
                      decoration: InputDecoration(
                          hintText: 'Enter text here....',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Length",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Slider(
                          thumbColor: Color(0xFF077A37),
                          activeColor: Color(0xFFf4f3fa),
                          inactiveColor: Color(0xFFf4f3fa),
                          min: 0,
                          max: 100,
                          divisions: 2,
                          onChanged: (value) {
                            setState(() {
                              sliderValOne = value;
                              print("Slidewrvalueone::${sliderValOne}");
                              if(sliderValOne==50)
                                {
                                  word=500;
                                }
                              if(sliderValOne==100)
                                {
                                  word=1000;
                                }
                              if(sliderValOne==0)
                                {
                                  word=200;
                                }
                            });
                          },
                          value: sliderValOne),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Short",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            Text(
                              "Medium",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            Text(
                              "Long",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "up to ${word} word",
                      style: TextStyle(color: Colors.grey),
                    )),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Tone",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Slider(
                          thumbColor: Color(0xFF077A37),
                          activeColor:  Color(0xFFf4f3fa),
                          inactiveColor: Color(0xFFf4f3fa),
                          divisions: 2,
                          min: 0,
                          max: 100,
                          onChanged: (value) {
                            setState(() {
                              sliderValTwo = value;
                              print("Slidewrvaluetwo::${sliderValTwo}");
                            });
                          },
                          value: sliderValTwo),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Formal",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            Text(
                              "Neutral",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            Text(
                              "Friendly",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Get premium",
                      style: TextStyle(
                          color: Color(0xFF077A37),
                          fontWeight: FontWeight.bold),
                    )),
                Text(
                  "You have 0 free message left",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {

                      call_api();


                  },
                  child: Container(
                    height: 40,
                    width: 140,
                    color: Color(0xFF077A37),
                    child: Center(
                        child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )),
                  ),
                )
              ],
            ),
          )),
        ),
        backgroundColor: Color(0xFFf4f3fa),
      ),
    );
  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}
