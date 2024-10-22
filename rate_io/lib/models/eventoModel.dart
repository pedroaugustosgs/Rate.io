import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_io/classes/evento.dart'; // Ajuste o caminho conforme necessário

class EventoModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create
  Future<void> create(Evento evento) async {
    DocumentReference docRef = await _firestore.collection('eventos').add(evento.toMap());
    evento.id = docRef.id; // Atualiza o id da instância com o id do documento criado
  }

  // Read
  Future<Evento?> read(String id) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('eventos').doc(id).get();
    if (docSnapshot.exists) {
      return Evento.fromMap(docSnapshot.data() as Map<String, dynamic>);
    }
    return null; // Retorna null se o documento não existir
  }

  // Update
  Future<void> update(Evento evento) async {
    if (evento.id != null) {
      await _firestore.collection('eventos').doc(evento.id).update(evento.toMap());
    }
  }

  // Delete
  Future<void> delete(Evento evento) async {
    if (evento.id != null) {
      await _firestore.collection('eventos').doc(evento.id).delete();
    }
  }
}
