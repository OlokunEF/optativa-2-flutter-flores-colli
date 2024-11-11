class RespuestaLoginUsuario {
  String accessToken;

  RespuestaLoginUsuario({
    required this.accessToken,
  });

  factory RespuestaLoginUsuario.fromJson(Map<String, dynamic> json) {
    return RespuestaLoginUsuario(
      accessToken: json["accessToken"],
    );
  }
}
