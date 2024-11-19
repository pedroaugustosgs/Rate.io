enum Sexo {
  masculino,
  feminino,
  naoInformado,
}

extension SexoExtension on Sexo {
  static Sexo fromString(String sexoString) {
    return Sexo.values.firstWhere(
        (e) => e.toString().split('.').last == sexoString,
        orElse: () => Sexo.naoInformado,
      );
  }
}