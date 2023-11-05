import 'package:flutter/material.dart';
import 'materia.dart';
import 'db.dart';
import 'tarea.dart';
import 'package:dam_u3_practica1/modificarMateria.dart';

class P31 extends StatefulWidget {
  const P31({super.key});

  @override
  State<P31> createState() => _P31State();
}

class _P31State extends State<P31> {
  int _index=1;
  String titulo="📓 Administrar materias";
  //Controladores de Materia
  final idmateria=TextEditingController();
  final nombreM=TextEditingController();
  final semestre=TextEditingController();
  final docente=TextEditingController();
  //Controladores de Tarea
  final idtarea=TextEditingController();
  final idmateriat=TextEditingController();
  final estado=TextEditingController();
  final descripcion=TextEditingController();

  Materia estGlob=Materia(
      idmateria: "",
      nombre: "",
      semestre: "",
      docente: ""
  );
  List<Materia> data = [];

  void actualizarLista() async{
    List<Materia> temp=await DB.mostrarTodos();
    setState(() {
      data=temp;
    });
  }

  Tarea estGlobT=Tarea(
      idtarea: 0,
      idmateria: "",
      entrega: "",
      descripcion: ""
  );
  List<Tarea> data2=[];

  void actualizarTareas() async{
    List<Tarea> tempT=await DB.mostrarTodasTareas();
    setState(() {
      data2=tempT;
    });
  }
  @override
  void initState(){
    actualizarLista();
    actualizarTareas();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${titulo}"),
      ),
      body: dinamico(),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text("Alumno",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white
                        ),
                      )
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage("assets/fondo.jpeg"),
                  fit: BoxFit.fill
                )
              ),
            ),
            SizedBox(height: 30,),
            _item(Icons.add, "Agregar materia", 0),
            _item(Icons.edit,"Administrar materia",1),
            _item(Icons.house, "Tareas", 2)
          ],
        ),
      ),
    );
  }

  Widget _item(IconData icon,String text,int indi){
    return ListTile(
      onTap: (){
        setState(() {
          _index=indi;
          if(indi==0){
            titulo="📚 Agregar materia";
          }if(indi==1){
            titulo="📓 Administrar materias";
          }if(indi==2){
            titulo="📄 Tareas";
          }
        });
        Navigator.pop(context);
      },
      title: Row(
        children: [
          SizedBox(height: 15,),
          Expanded(child: Icon(icon,size: 30,)),
          SizedBox(height: 10,),
          Expanded(child: Text(text,style: TextStyle(fontSize: 16)),flex: 6,),

        ],
      ),
    );
  }

  Widget dinamico(){
    switch (_index){
      case 0:{
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image(
                  image: AssetImage("assets/materia.jpeg"),
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Text("📚 Agregar nueva materia",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextField(
                        controller: idmateria,
                        decoration: InputDecoration(
                          labelText: "Id de la materia",
                        ),
                      ),
                      TextField(
                        controller: nombreM,
                        decoration: InputDecoration(
                            labelText: "Nombre de la materia"
                        ),
                      ),
                      TextFormField(
                        controller: semestre,
                        decoration: new InputDecoration(
                          labelText: 'Semestre',
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                      ),
                      TextField(
                        controller: docente,
                        decoration: InputDecoration(
                            labelText: "Docente"
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: (){
                                var temp=Materia(
                                  idmateria: idmateria.text,
                                  nombre: nombreM.text,
                                  semestre: semestre.text,
                                  docente: docente.text,
                                );
                                DB.insertar(temp).then((value){
                                  setState(() {
                                    titulo="Se inserto correctamente👍🏻";
                                  });
                                  idmateria.text="";
                                  nombreM.text="";
                                  semestre.text="";
                                  docente.text="";
                                  actualizarLista();
                                });
                              },
                              child: Text("Agregar")
                          ),
                          ElevatedButton(
                              onPressed: (){

                              },
                              child: Text("Limpiar")),
                        ],
                      )

                    ],
                  ),
                )
              ],
            ),
          ),
        );//INTERFAZ DE AGREGAR MATERIA
      }
      case 1:{
        return Column(
          children: <Widget>[
            Image(image: AssetImage("assets/tarea.jpeg")),
            SizedBox(height: 20,),
            Text("Seleccione materia para agreagar tarea",
              style: TextStyle(
                fontSize: 20
              ),
            ),
            SizedBox(height: 20,),
            Expanded(child:
              ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, indice){
                  return ListTile(
                    title: Text("${data[indice].nombre}"),
                    subtitle: Text("Semestre: ${data[indice].semestre}     Docente:${data[indice].docente}"),
                    leading: CircleAvatar(child: Text("${data[indice].idmateria}"), radius: 10,),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: (){
                            estGlob=data[indice];
                            Navigator.push(context, MaterialPageRoute(
                                builder: (builder){
                                  return ModMat(
                                      data[indice].idmateria,
                                      data[indice].nombre,
                                      data[indice].semestre,
                                      data[indice].docente
                                  );
                                }
                            )
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: (){
                            DB.eliminar(data[indice].idmateria).then((value){
                            setState(() {
                              titulo="Se elimino correctamente👍🏻";
                            });
                              actualizarLista();
                            });
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                    onTap: (){
                      estGlob=data[indice];
                      agregarTarea(data[indice], indice);
                      setState(() {
                        idmateriat.text=data[indice].idmateria;
                      });
                      actualizarLista();
                    },
                  );
              }),
            )
          ],
        );//INTERFAZ DE ADMIN MATERIA
      }
      case 2:{
        return ListView.builder(
        itemCount: data2.length,
        itemBuilder: (context, indice){
          return Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amberAccent,
              ),
              height: 75,
              child: ListTile(
                title: Text("${data2[indice].descripcion}"),
                subtitle: Text("Fecha de entrega: ${data2[indice].entrega}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: (){
                        setState(() {
                          actualizarTareas();
                        });
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: (){
                        DB.eliminarT(data2[indice].idtarea).then((value){
                          setState(() {
                            titulo="Se elimino correctamente👍🏻";
                          });
                          actualizarTareas();
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
                onTap: (){
                  setState(() {

                  });
                },
              ),
            ),
          );
        });//INTERFAZ DE ADMIN TAREAS
      }
      default:{
        return Center();
      }
    }
  }

  void agregarTarea(Materia p, int ind) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 5,
        builder: (builder) {
          return Container(
            padding: EdgeInsets.only(
                top: 15,
                left: 30,
                right: 30,
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom + 50
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Agregar Tarea",
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                  TextField(
                    enabled: false,
                    controller: idmateriat,
                    decoration: InputDecoration(
                      labelText: "Materia"
                    ),
                  ),
                  TextField(
                    controller: estado,
                    decoration: InputDecoration(
                      labelText: "Fecha de entrega"
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  TextField(
                    controller: descripcion,
                    decoration: InputDecoration(
                      labelText: "Descripcion"
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            var tempT=Tarea(
                              idmateria: idmateriat.text,
                              entrega: estado.text,
                              descripcion: descripcion.text,
                            );
                            DB.insertarT(tempT).then((value) {
                              setState(() {
                                titulo = "Se inserto correctamente👍🏻";
                              });
                              idmateriat.text = "";
                              estado.text = "";
                              descripcion.text = "";
                              actualizarTareas();
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Agregar")
                      ),
                      ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                            idmateriat.text = "";
                            estado.text = "";
                            descripcion.text = "";
                          },
                          child: Text("Cancelar")
                      ),
                    ],
                  )
                ]
            ),
          );
        }
    );
  }

}
