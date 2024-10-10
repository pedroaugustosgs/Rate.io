import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  // Inicializa o Firebase
  await Firebase.initializeApp();

  // Chama a função para criar as coleções
  await createCollections();
}

Future<void> createCollections() async {
  final firestore = FirebaseFirestore.instance;

  // Lista de coleções que você deseja criar
  List<String> collections = [
    'usuarios',
  ];

  try {
    for (String collection in collections) {
      // Adiciona uma coleção (Firestore cria automaticamente se não existir)
      await firestore.collection(collection).doc('dummy').set({
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      print('Coleção "$collection" criada com sucesso.');
    }
  } catch (e) {
    print('Erro ao criar coleções: $e');
  }
}
