import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/tarefa.dart';

class TarefaModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create
  Future<void> create(Tarefa tarefa) async {
    DocumentReference docRef = await _firestore.collection('tarefas').add(tarefa.toMap());
    tarefa.id = docRef.id; // Atualiza o id da instância com o id do documento criado
  }

  // Read
  Future<Tarefa?> read(String id) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('tarefas').doc(id).get();
    if (docSnapshot.exists) {
      return Tarefa.fromMap(docSnapshot.data() as Map<String, dynamic>);
    }
    return null; // Retorna null se o documento não existir
  }

  // Update
  Future<void> update(Tarefa tarefa) async {
    if (tarefa.id != null) {
      await _firestore.collection('tarefas').doc(tarefa.id).update(tarefa.toMap());
    }
  }

  // Delete
  Future<void> delete(String id) async {
    await _firestore.collection('tarefas').doc(id).delete();
  }
}
