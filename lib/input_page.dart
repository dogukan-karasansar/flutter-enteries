import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

enum Cinsiyet {
  kadin,
  erkek,
  bos,
}

const okullar = ['İlkokul', 'Ortaokul', 'Lise', 'Üniversite'];

class _InputPageState extends State<InputPage> {
  bool? okuldamisin = false;
  Cinsiyet? cinsiyet = Cinsiyet.bos;
  String? okul;
  double boy = 100;
  TextEditingController yorumController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    yorumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Girdi Sayfası'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Text(okuldamisin == true ? 'Okuldasın' : 'Okulda Değilsin'),
              Checkbox(
                  value: okuldamisin,
                  onChanged: (value) {
                    setState(() {
                      okuldamisin = value;
                    });
                  }),
              Switch(
                  value: okuldamisin!,
                  onChanged: (value) {
                    setState(() {
                      okuldamisin = value;
                    });
                  }),
              Radio<Cinsiyet>(
                  value: Cinsiyet.kadin,
                  groupValue: cinsiyet,
                  onChanged: (value) {
                    setState(() {
                      cinsiyet = value;
                    });
                  }),
              Radio<Cinsiyet>(
                  value: Cinsiyet.erkek,
                  groupValue: cinsiyet,
                  onChanged: (value) {
                    setState(() {
                      cinsiyet = value;
                    });
                  }),
              Text(cinsiyet.toString()),
              DropdownButtonFormField<String>(
                  value: okul,
                  validator: (value) {
                    if(!okullar.contains(value)){
                      return 'Lütfen Okul Seçin';
                    }
                  },
                  onSaved: (newValue) {
                    print('Okul Kaydedildi');
                  },
                  items: okullar
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      okul = value;
                    });
                  }),
              Text(okul != null ? okul.toString() : ''),
              Slider(
                value: boy,
                onChanged: (double value) {
                  setState(() {
                    boy = value;
                  });
                },
                min: 30,
                max: 200,
              ),
              Text(boy.toStringAsFixed(2)),
              TextFormField(
                controller: yorumController,
                onChanged: (value) {
                  setState(() {});
                },
                validator: (value){
                  if(value != null){
                    if(value.isEmpty){
                      return 'Boş Bırakılamaz';
                    } else {
                      return null;
                    }
                  } else {
                    return 'null olamaz';
                  }
                },
                onSaved: (newValue){
                  print('Yorum Kaydediliyor');
                },
              ),
              Text(yorumController.text),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      okuldamisin = false;
                      cinsiyet = Cinsiyet.bos;
                      okul;
                      boy = 100;
                      yorumController.text = '';
                    });
                  },
                  child: Text('Temizle')),
              ElevatedButton(
                  onPressed: () {
                    final success = formkey.currentState?.validate();
                    if(success == true){
                      formkey.currentState?.save();
                      print('sunucyua gidiyor');
                    }

                  },
                  child: Text('Gönder'))
            ],
          ),
        ),
      ),
    );
  }
}
