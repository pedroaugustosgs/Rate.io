import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/caixa.dart'; // Ajuste o caminho conforme necessário

class CaixaModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create
  Future<void> create(Caixa caixa) async {
    DocumentReference docRef = await _firestore.collection('caixas').add(caixa.toMap());
    caixa.id = docRef.id; // Atualiza o id da instância com o id do documento criado
  }

  // Read
  Future<Caixa?> read(String id) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('caixas').doc(id).get();
    if (docSnapshot.exists) {
      return Caixa.fromMap(docSnapshot.data() as Map<String, dynamic>);
    }
    return null; // Retorna null se o documento não existir
  }

  // Update
  Future<void> update(Caixa caixa) async {
    if (caixa.id != null) {
      await _firestore.collection('caixas').doc(caixa.id).update(caixa.toMap());
    }
  }

  // Delete
  Future<void> delete(Caixa caixa) async {
    if (caixa.id != null) {
      await _firestore.collection('caixas').doc(caixa.id).delete();
    }
  }
}
