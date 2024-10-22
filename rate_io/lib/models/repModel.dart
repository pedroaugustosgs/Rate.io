import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/rep.dart';

class RepModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create
  Future<void> create(Rep rep) async {
    DocumentReference docRef = await _firestore.collection('reps').add(rep.toMap());
    rep.id = docRef.id; // Atualiza o id da instância com o id do documento criado
  }

  // Read
  Future<Rep?> read(String id) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('reps').doc(id).get();
    if (docSnapshot.exists) {
      return Rep.fromMap(docSnapshot.data() as Map<String, dynamic>);
    }
    return null; // Retorna null se o documento não existir
  }

  // Update
  Future<void> update(Rep rep) async {
    if (rep.id != null) {
      await _firestore.collection('reps').doc(rep.id).update(rep.toMap());
    }
  }

  // Delete
  Future<void> delete(String id) async {
    await _firestore.collection('reps').doc(id).delete();
  }
}
