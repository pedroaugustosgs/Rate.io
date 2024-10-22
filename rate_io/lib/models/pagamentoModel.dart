import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/pagamento.dart';

class PagamentoModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create
  Future<void> create(Pagamento pagamento) async {
    DocumentReference docRef = await _firestore.collection('pagamentos').add(pagamento.toMap());
    pagamento.id = docRef.id; // Atualiza o id da instância com o id do documento criado
  }

  // Read
  Future<Pagamento?> read(String id) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('pagamentos').doc(id).get();
    if (docSnapshot.exists) {
      return Pagamento.fromMap(docSnapshot.data() as Map<String, dynamic>);
    }
    return null; // Retorna null se o documento não existir
  }

  // Update
  Future<void> update(Pagamento pagamento) async {
    if (pagamento.id != null) {
      await _firestore.collection('pagamentos').doc(pagamento.id).update(pagamento.toMap());
    }
  }

  // Delete
  Future<void> delete(String id) async {
    await _firestore.collection('pagamentos').doc(id).delete();
  }
}
