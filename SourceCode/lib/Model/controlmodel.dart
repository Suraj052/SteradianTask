class Control
{
  bool selfie;

  Control({
    required this.selfie,
  });

  static Control fromJson(Map<String,dynamic> json)=>
      Control(
        selfie: json['selfie'],
      );

  Map<String,dynamic> toJson() =>
      {
        'selfie' : selfie,
      };

}