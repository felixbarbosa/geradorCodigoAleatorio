import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum SingingCharacter { nome, cnpj }

class Home extends StatefulWidget {

  const Home(
    {
      Key? key, 
    }
  ) : super(key: key);

  @override
  _HomeState createState() => _HomeState(
  );
}

class _HomeState extends State<Home> {


  _HomeState(
  );

  SingingCharacter? _character = SingingCharacter.nome;

  final _formKey = GlobalKey<FormState>();
  final endereco = TextEditingController();

  int numeroInicial = 0;
  int numeroFinal = 0;
  Random random = new Random();
  int indexLetra = 0; //0 - 25
  String codigoGerado = "";
  String dia = "0";
  String mes = "0";
  String ano = "0";
  String dataFormatadaInicio = "";
  String dataMostradaInicio = "";
  bool isCheckHora = false;
  int notificarHora = 0;
  bool isCheckTurno = false;
  int notificarTurno = 0;
  String horaCompletaMostrada = "";
  String horaMostrada = "";
  String minutoMostrado = "";

  DateTime dataSelecionada = DateTime.now();
  TimeOfDay horaSelecionada = TimeOfDay.now();

  List<String> letras = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r",
  "s", "t", "u", "v", "w", "x", "y", "z"];

  List<String> turnos = ["Manhã", "Tarde", "Noite"];

  @override
  void initState() {
    super.initState();

    dia = DateTime.now().day.toString();
    mes = DateTime.now().month.toString();
    ano = DateTime.now().year.toString();

    if(dia.length < 2){
      dia = "0" + DateTime.now().day.toString();
    }

    if(mes.length < 2){
      mes = "0" + DateTime.now().month.toString();
    }

    if(horaSelecionada.hour < 10){

      horaMostrada = "0" + horaSelecionada.hour.toString();

    }else{
      horaMostrada = horaSelecionada.hour.toString();
    }
    
    if(horaSelecionada.minute < 10){

      minutoMostrado = "0" + horaSelecionada.minute.toString();

    }else{

      minutoMostrado = horaSelecionada.minute.toString();
    
    }

    horaCompletaMostrada = horaMostrada + ":" + minutoMostrado;

    dataMostradaInicio = dia + "/" + mes + "/" + ano;
    dataFormatadaInicio = ano + "-" + mes + "-" + dia;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    return OrientationBuilder(
      builder: (context, orientation){
        print(orientation);
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/logo_rosa_cake.jpg"),
                fit: BoxFit.cover,
                alignment: Alignment.center,
                opacity: 0.2
              )
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/9.82, 0, MediaQuery.of(context).size.width/9.82, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Data da Entrega",
                      style: TextStyle(
                        fontSize: 23
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.date_range,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 85,
                              ),
                              Text(
                                dataMostradaInicio,
                                style: TextStyle(
                                  color: Colors.black
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: (){
                        showDatePicker(
                          context: context, 
                          initialDate: dataSelecionada, 
                          firstDate: DateTime(2001), 
                          lastDate: DateTime(2050)
                        ).then((value) {
                          
                          dia = value!.day.toString();
                          mes = value.month.toString();
                          ano = value.year.toString();

                          if(dia.length < 2){
                            dia = "0" + value.day.toString();
                          }

                          if(mes.length < 2){
                            mes = "0" + value.month.toString();
                          }

                          setState(() {
                            dataSelecionada = value;
                            dataFormatadaInicio = ano + "-" + mes + "-" + dia;
                            dataMostradaInicio = dia + "/" + mes + "/" + ano;
                          });
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/7.85,0,0,0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Checkbox(
                              value: isCheckHora, 
                              onChanged: (value) {
                                setState(() {
                                  isCheckHora = value!;
                                  if(isCheckHora == true){
                                    notificarHora = 1;
                                    setState(() {
                                      isCheckTurno = false;
                                    });
                                  }else{
                                    notificarHora = 0;
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Hora'
                          ),
                          SizedBox(
                            width: 98,
                          ),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Checkbox(
                              value: isCheckTurno, 
                              onChanged: (value) {
                                setState(() {
                                  isCheckTurno = value!;
                                  if(isCheckTurno == true){
                                    notificarTurno = 1;
                                    setState(() {
                                      isCheckHora = false;
                                    });
                                  }else{
                                    notificarTurno = 0;
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Turno'
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    isCheckHora ?
                    Text(
                      "Hora da Entrega",
                      style: TextStyle(
                        fontSize: 23
                      ),
                    ) : Container(),
                    isCheckHora ?
                    SizedBox(
                      height: 8,
                    ) : Container(),
                    isCheckHora ?
                    GestureDetector(
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.watch_later,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 103,
                              ),
                              Text(
                                horaCompletaMostrada,
                                style: TextStyle(
                                  color: Colors.black
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () async{
                        final TimeOfDay? timeOfDay = await showTimePicker(
                          context: context,
                          initialTime: horaSelecionada,
                          initialEntryMode: TimePickerEntryMode.dial,
                        );
                        if(timeOfDay != null && timeOfDay != horaSelecionada){

                          setState(() {
                            horaSelecionada = timeOfDay;

                            if(horaSelecionada.hour < 10){

                              horaMostrada = "0" + horaSelecionada.hour.toString();

                            }else{
                              horaMostrada = horaSelecionada.hour.toString();
                            }
                            
                            if(horaSelecionada.minute < 10){

                              minutoMostrado = "0" + horaSelecionada.minute.toString();

                            }else{

                              minutoMostrado = horaSelecionada.minute.toString();
                            
                            }

                            horaCompletaMostrada = horaMostrada + ":" + minutoMostrado;
                          });

                        }
                      },
                    ) : Container(),
                    isCheckTurno ? 
                    Text(
                      "Turno da Entrega",
                      style: TextStyle(
                        fontSize: 23
                      ),
                    ): Container(),
                    isCheckTurno ?
                    SizedBox(
                      height: 8,
                    ) : Container(),
                    isCheckTurno ?
                    Container(
                      height: 55,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        dropdownColor: Colors.white,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.black,
                        items: turnos.map((String value){
                          return DropdownMenuItem(
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                              
                            ),
                            value: value,
                          );
                        }).toList(),  
                        onChanged: (valorSelecionado){

                          if(valorSelecionado != null){
                            setState(() {
                              //selecionouRamoAtividade = true;
                            });
                          }
                          
                          
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Turno",
                          hintStyle: TextStyle(
                            color: Colors.black
                          )
                        ),
                      ),
                    ) : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Endereço da Entrega",
                      style: TextStyle(
                        fontSize: 23
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 100.0,
                      child: TextFormField(
                        controller: endereco,
                        maxLines: 5,
                        style: TextStyle(
                          color: Colors.black
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Endereço da Entrega",
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12.0
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.pink[100],
                      
                      onPressed: (){

                        //codigoGerado = random.nextInt(9999 - 1001) + 1000; // 1000 -> 9999
                        numeroInicial = random.nextInt(9); // 0 - 9
                        indexLetra = random.nextInt(25); // 0 - 25
                        numeroFinal = random.nextInt(99 - 11) + 10; // 10 - 99

                        codigoGerado = numeroInicial.toString() + letras[indexLetra].toUpperCase() + numeroFinal.toString();

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.white,
                            title: Center(
                              child: Text(
                                "Códgio Gerado:",
                                style: TextStyle(
                                  color: Colors.black
                                ),
                              ),
                            ),
                            content: Padding(
                              padding: EdgeInsets.fromLTRB(orientation == Orientation.portrait ? MediaQuery.of(context).size.width/6.04 : MediaQuery.of(context).size.width/12.16,0,0,0),
                              child: Row(
                                children: [
                                  Text(
                                    codigoGerado,
                                    style: TextStyle(
                                      color: Colors.pink[100],
                                      fontSize: 40
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.copy_outlined,
                                      color: Colors.black,
                                    ),
                                    onPressed: () async {
                                      print("Clicou");
                                      await Clipboard.setData(ClipboardData(text: codigoGerado));
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        backgroundColor: Colors.pink[400],
                                        content: Padding(
                                          padding: EdgeInsets.fromLTRB(orientation == Orientation.portrait ? MediaQuery.of(context).size.width/4.5 : MediaQuery.of(context).size.width/2.84, 0, 0, 0),
                                          child: Text(
                                            'Código copiado com sucesso!',
                                            style: TextStyle(
                                              color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ));
                                    },
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Fechar',
                                  style: TextStyle(
                                    color: Colors.black
                                  ),
                                ),
                              ),
                            ],
                          )
                        );

                      },
                      shape: CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Icon(
                            Icons.auto_fix_high_rounded,
                            size: 40,
                          ),
                        ),
                      ),
                      elevation: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Gerar Código",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  mostrarCodigo(){
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.black,
      ),
    );
  }

}

indicadorProgresso(){
  return Expanded(
      child: Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: Container(
        child: Center(
          child: CircularProgressIndicator()
        )
      ),
    ),
  );
}

 