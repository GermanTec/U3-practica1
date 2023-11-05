import 'package:flutter/material.dart';
import 'materia.dart';
import 'db.dart';
import 'package:dam_u3_practica1/practica1.dart';

 class ModMat extends StatefulWidget {
   String idmateria;
   String nombre;
   String semestre;
   String docente;

   ModMat(this.idmateria,this.nombre,this.semestre,this.docente);

   @override
   State<ModMat> createState() => _ModMatState();
 }

 class _ModMatState extends State<ModMat> {
   int _index=0;
   String titulo="";
   //Controladores de Materia
   final idmateria=TextEditingController();
   final nombreM=TextEditingController();
   final semestre=TextEditingController();
   final docente=TextEditingController();

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

   @override
   void initState() {
    setState(() {
      idmateria.text=widget.idmateria;
      nombreM.text=widget.nombre;
      semestre.text=widget.semestre;
      docente.text=widget.docente;
      actualizarLista();
    });
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("${titulo}"),
       ),
       body: ListView(
         padding: EdgeInsets.all(40),
       children: [
         Text("Materia ID: ${widget.idmateria}", style: TextStyle(fontSize: 20),),
         SizedBox(height: 10,),
         TextField(
           controller: nombreM,
           decoration: InputDecoration(
            labelText: "Nombre:"
           ),
         ),
         SizedBox(height: 10,),
         TextField(
           controller: semestre,
           decoration: InputDecoration(
            labelText: "Semestre:"
           ),
           keyboardType: TextInputType.number,
         ),
         SizedBox(height: 10,),
         TextField(
           controller: docente,
           decoration: InputDecoration(
            labelText: "Docente:"
           ),
         ),
         SizedBox(height: 10,),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
            onPressed: (){
               estGlob.idmateria=idmateria.text;
               estGlob.nombre=nombreM.text;
               estGlob.docente=docente.text;
               estGlob.semestre=semestre.text;
              DB.actualizar(estGlob).then((value) {
              if(value>0){
              setState(() {
                titulo="SE ACTUALIZO CORRECTAMENTE👍🏻";
              });
             idmateria.text="";
             nombreM.text="";
             docente.text="";
             semestre.text="";
             estGlob=Materia(
               idmateria: "",
               nombre: "",
               docente: "",
               semestre: ""
             );
              actualizarLista();
             }
             });
               Navigator.push(context, MaterialPageRoute(builder: (builder){return P31();}));
            },
            child: Text("Actualizar")
          ),
         ElevatedButton(
         onPressed: (){
           idmateria.text="";
           nombreM.text="";
           docente.text="";
           semestre.text="";
           estGlob=Materia(
              idmateria: "",
              nombre: "",
              docente: "",
              semestre: ""
           );
           Navigator.pop(context);
           actualizarLista();
         },
         child: Text("Cancelar")
         ),
         ],
         )
       ],
     ),
     );
   }
 }
