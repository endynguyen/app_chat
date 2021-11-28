class Message{

  late final String text;
  late final DateTime date;
  late final String email1;
  late final String email2;
  Message(this.email1,this.email2,this.text,this.date);

  Message.fromJson(Map<dynamic, dynamic> json)
      : date = DateTime.parse(json['date'] as String),
        email1 = json['text'] as String,
        email2 = json['text'] as String,
        text = json['text'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'date': date.toString(),
    'text': email1,
    'text': email2,
    'text': text,
  };
}