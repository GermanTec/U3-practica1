import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:dam_u3_practica1/materia.dart';

class DB{
  static Future<Database> _abrirDB() async{
    return openDatabase(
      join(await getDatabasesPath(), "practica1.db"),
        onCreate: (db,version){
          return db.execute(
              "CREATE TABLE MATERIA("
                  "IDMATERIA TEXT PRIMARY KEY, "
                  "NOMBRE TEXT, "
                  "SEMESTRE TEXT,"
                  "DOCENTE TEXT)"
          );
        },
        version: 1
    );
  }

  static Future<int> insertar(Materia e) async{
    Database db= await _abrirDB();
    return db.insert("MATERIA", e.toJSON(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Materia>> mostrarTodos() async{
    Database db=await _abrirDB();
    List<Map<String,dynamic>> resultado=await db.query("MATERIA");
    return List.generate(resultado.length , (index){
      return Materia(
          idmateria: resultado[index]['IDMATERIA'],
          nombre: resultado[index]['NOMBRE'],
          semestre: resultado[index]['SEMESTRE'],
          docente: resultado[index]['DOCENTE']
      );
    });
  }

  static Future<int> actualizar(Materia e) async{
    Database db=await _abrirDB();
    return db.update("MATERIA", e.toJSON(),where: "IDMATERIA=?",whereArgs: [e.idmateria]);
  }

  static Future<int> eliminar(String idmateria) async{
    Database db=await _abrirDB();
    return db.delete("MATERIA",where: "IDMATERIA=?",whereArgs: [idmateria]);
  }
}