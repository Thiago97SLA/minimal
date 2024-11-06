class CustomLogger {
  static void logError(String message, String? stackTrace) {
    log('//////////////////////////////////////////');
    log('######### AN ERROR HAS OCURRED ###########');
    log('Error:');
    log(message);
    if (stackTrace != null) {
      log('StackTrace :');
      log(stackTrace);
    }
    log('############# END ERROR ##################');
    log('//////////////////////////////////////////');
  }

  static void log(String message) {
    // ignore: avoid_print
    print(message);
  }
}
