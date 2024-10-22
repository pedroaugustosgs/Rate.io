import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/avaliaRep.dart'; // Certifique-se de que o caminho do import está correto

class AvaliaRepModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create
  Future<void> create(AvaliaRep avaliacao) async {
    DocumentReference docRef = await _firestore.collection('avaliacoes_rep').add(avaliacao.toMap());
    avaliacao.id = docRef.id; // Atualiza o id da instância com o id do documento criado
  }

  // Read
  Future<AvaliaRep?> read(String id) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('avaliacoes_rep').doc(id).get();
    if (docSnapshot.exists) {
      return AvaliaRep.fromMap(docSnapshot.data() as Map<String, dynamic>);
    }
    return null; // Retorna null se o documento não existir
  }

  // Update
  Future<void> update(AvaliaRep avaliacao) async {
    if (avaliacao.id != null) {
      await _firestore.collection('avaliacoes_rep').doc(avaliacao.id).update(avaliacao.toMap());
    }
  }

  // Delete
  Future<void> delete(AvaliaRep avaliacao) async {
    if (avaliacao.id != null) {
      await _firestore.collection('avaliacoes_rep').doc(avaliacao.id).delete();
    }
  }
}
