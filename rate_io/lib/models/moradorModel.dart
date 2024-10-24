import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/morador.dart';

class MoradorModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create
  Future<void> create(Morador morador) async {
    DocumentReference docRef = await _firestore.collection('moradores').add(morador.toMap());
    morador.id = docRef.id; // Atualiza o id da instância com o id do documento criado
  }

  // Read
  Future<Morador?> read(String id) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('moradores').doc(id).get();
    if (docSnapshot.exists) {
      return Morador.fromMap(docSnapshot.data() as Map<String, dynamic>);
    }
    return null; // Retorna null se o documento não existir
  }

  // Update
  Future<void> update(Morador morador) async {
    if (morador.id != null) {
      await _firestore.collection('moradores').doc(morador.id).update(morador.toMap());
    }
  }

  // Delete
  Future<void> delete(String id) async {
    await _firestore.collection('moradores').doc(id).delete();
  }
}
