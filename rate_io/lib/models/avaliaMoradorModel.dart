import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/avaliaMorador.dart';

class AvaliaMoradorModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create
  Future<void> create(AvaliacaoMorador avaliacao) async {
    DocumentReference docRef = await _firestore.collection('avaliacoes').add(avaliacao.toMap());
    avaliacao.id = docRef.id; // Atualiza o id da instância com o id do documento criado
  }

  // Read
  Future<AvaliacaoMorador?> read(String id) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('avaliacoes').doc(id).get();
    if (docSnapshot.exists) {
      return AvaliacaoMorador.fromMap(docSnapshot.data() as Map<String, dynamic>);
    }
    return null; // Retorna null se o documento não existir
  }

  // Update
  Future<void> update(AvaliacaoMorador avaliacao) async {
    if (avaliacao.id != null) {
      await _firestore.collection('avaliacoes').doc(avaliacao.id).update(avaliacao.toMap());
    }
  }

  // Delete
  Future<void> delete(AvaliacaoMorador avaliacao) async {
    if (avaliacao.id != null) {
      await _firestore.collection('avaliacoes').doc(avaliacao.id).delete();
    }
  }
}
