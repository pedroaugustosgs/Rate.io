import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/despesas.dart';

class DespesaModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create
  Future<void> create(Despesa despesa) async {
    DocumentReference docRef = await _firestore.collection('despesas').add(despesa.toMap());
    despesa.id = docRef.id; // Atualiza o id da instância com o id do documento criado
  }

  // Read
  Future<Despesa?> read(String id) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('despesas').doc(id).get();
    if (docSnapshot.exists) {
      return Despesa.fromMap(docSnapshot.data() as Map<String, dynamic>);
    }
    return null; // Retorna null se o documento não existir
  }

  // Update
  Future<void> update(Despesa despesa) async {
    if (despesa.id != null) {
      await _firestore.collection('despesas').doc(despesa.id).update(despesa.toMap());
    }
  }

  // Delete
  Future<void> delete(Despesa despesa) async {
    if (despesa.id != null) {
      await _firestore.collection('despesas').doc(despesa.id).delete();
    }
  }
}
