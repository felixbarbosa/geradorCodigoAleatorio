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

  int numeroInicial = 0;
  int numeroFinal = 0;
  Random random = new Random();
  int indexLetra = 0; //0 - 25
  String codigoGerado = "";
  List<String> letras = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r",
  "s", "t", "u", "v", "w", "x", "y", "z"];

  @override
  void initState() {
    super.initState();
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Icon(
                          Icons.auto_fix_high_rounded,
                          size: 70,
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
                      fontSize: 25
                    ),
                  ),
                ],
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

 