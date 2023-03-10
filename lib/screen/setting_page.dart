import 'package:ai_writer/screen/privacy.dart';
import 'package:ai_writer/screen/terms_of_use.dart';
import 'package:flutter/material.dart';

class setiing_page extends StatefulWidget {
  const setiing_page({Key? key}) : super(key: key);

  @override
  State<setiing_page> createState() => _setiing_pageState();
}

class _setiing_pageState extends State<setiing_page> {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AI Write",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20,),
              Container(
                height: 70,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Align(alignment: Alignment.topLeft,child: Text("AI Write",style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),)),
                      Align(alignment: Alignment.topLeft,child: Text("Version 1.0",style: TextStyle(fontSize: 18,color: Colors.grey),)),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),

                child: ListTile(
                  onTap: () {

                  },
                  title: Text("Upgrade",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),),
                  trailing: Icon(Icons.arrow_forward_ios),

                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),

                child: ListTile(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) {
                      return terms_of_use();
                    },));
                  },
                  title: Text("Terms of Use",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),),
                  trailing: Icon(Icons.arrow_forward_ios),

                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),

                child: ListTile(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) {
                      return privacy();
                    },));
                  },
                  title: Text("Privacy Policy",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),),
                  trailing: Icon(Icons.arrow_forward_ios),

                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),

                child: ListTile(
                  onTap: () {

                  },
                  title: Text("More",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),),
                  trailing: Icon(Icons.arrow_forward_ios),

                ),
              ),

            ],
          ),
        ),
      ),backgroundColor: Color(0xFFf4f3fa),
    );
  }
}
