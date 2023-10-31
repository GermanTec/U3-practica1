import 'package:flutter/material.dart';
import 'materia.dart';

class P31 extends StatefulWidget {
  const P31({super.key});

  @override
  State<P31> createState() => _P31State();
}

class _P31State extends State<P31> {
  int _index=0;
  int _indice=0;
  String titulo="";
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
                  image: NetworkImage("https://c.wallhere.com/photos/fa/d0/material_style_shapes_colorful-120490.jpg!d"),
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

  Widget _item(IconData icon,String text,int indice){
    return ListTile(
      onTap: (){
        setState(() {
          _index=indice;
          if(indice==0){
            titulo="📚 Agregar materia";
          }if(indice==1){
            titulo="Administrar materias";
          }if(_indice==2){
            titulo="Tareas";
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
        return Center(
          child: Column(
            children: [
              Image(
                image: NetworkImage("https://previews.123rf.com/images/dirkercken/dirkercken1110/dirkercken111000058/10985718-libros-de-educación-del-estudio-con-la-construcción-de-conocimiento-del-texto-de-aprendizaje-en-la.jpg"),
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
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                    TextField(
                      controller: docente,
                      decoration: InputDecoration(
                        labelText: "Docente"
                      ),
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: (){}, child: Text("Agregar")),
                        ElevatedButton(onPressed: (){}, child: Text("Limpiar"))
                      ],
                    )

                  ],
                ),
              )
            ],
          ),
        );
      }
      case 1:{
        return Center(
          child: Column(
            children: [
              Image(
                image: NetworkImage("https://cdn.welcometothejungle.co/uploads/article/social_image/1455/158461/large_lista-tareas.jpg"),
                fit: BoxFit.fill,
              ),
              ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, indice){
                  return ListTile(
                    title: Text("Nombre de la materia"),
                    subtitle: Text("Docente"),
                    leading: CircleAvatar(child: Text("1"), radius: 15,),
                    trailing: IconButton(
                      onPressed: (){
                        setState(() {
                          titulo="Se elimino correctamente";
                        });
                    },
                    icon: Icon(Icons.delete),
                    ),
                    onTap: (){
                      setState(() {

                      });
                    },
                  );
              })
            ],
          ),
        );
      }
      default:{
        return Center();
      }
    }
  }

}
