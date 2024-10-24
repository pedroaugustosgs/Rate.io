import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/user.dart';

class UserModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create
  Future<void> create(UserSystem user) async {
    DocumentReference docRef = await _firestore.collection('users').add(user.toMap());
    user.id = docRef.id; // Atualiza o id da instância com o id do documento criado
  }

  // Read
  Future<UserSystem?> read(String id) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('users').doc(id).get();
    if (docSnapshot.exists) {
      return UserSystem.fromMap(docSnapshot.data() as Map<String, dynamic>);
    }
    return null; // Retorna null se o documento não existir
  }

  // Update
  Future<void> update(UserSystem user) async {
    if (user.id != null) {
      await _firestore.collection('users').doc(user.id).update(user.toMap());
    }
  }

  // Delete
  Future<void> delete(String id) async {
    await _firestore.collection('users').doc(id).delete();
  }
}
