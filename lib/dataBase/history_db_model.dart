import 'dart:convert';


List<H_data> s_history=[];
class H_data {

  int? id;
  String question_data;
  String ans_data;
  String current_time;
  // String? english;


  factory H_data.fromRawJson(String str) => H_data.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory H_data.fromJson(Map<String, dynamic> json) => H_data(

    id:json["id"],
    question_data: json["save_question"].toString(),
    ans_data: json["save_ans"].toString(),
    current_time: json["save_time"].toString(),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "save_question":question_data,
    "save_ans":ans_data,
    "save_time":current_time,
  };
  H_data({this.id,required this.question_data,required this.ans_data,required this.current_time});

}
