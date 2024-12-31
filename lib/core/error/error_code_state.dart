class ErrorCodeState {
  static String statusCode400 =
      "La solicitud enviada contiene datos no válidos. Por favor, verifica los campos e inténtalo de nuevo.";

  static String statusCode401 =
      "No tienes autorización para acceder a este recurso. Por favor, inicia sesión y vuelve a intentarlo.";

  static String statusCode403 =
      "No tienes permisos para realizar esta acción. Si crees que esto es un error, contacta al soporte.";

  static String statusCode404 =
      "El recurso que estás buscando no se encontró. Por favor, verifica la URL o intenta con otro recurso.";

  static String statusCode409 =
      "Hubo un conflicto con tu solicitud. Este recurso ya existe o no puede ser procesado.";

  static String statusCode500 =
      "Ocurrió un error inesperado en el servidor. Estamos trabajando para solucionarlo. Por favor, intenta más tarde.";

  static String statusCode502 =
      "Hubo un problema al conectar con el servidor. Por favor, intenta nuevamente más tarde.";

  static String statusCode503 =
      "El servicio no está disponible en este momento. Por favor, intenta más tarde.";

  //Errores de red o tiempo de espera
  static String timeout =
      "La solicitud tardó demasiado en responder. Verifica tu conexión a Internet e inténtalo de nuevo.";

  static String notNetwork =
      "No se detectó conexión a Internet. Por favor, verifica tu conexión e inténtalo nuevamente.";
}
