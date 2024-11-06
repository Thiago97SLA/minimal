enum DbConstants {
  tokenE(key: 'token'),
  token(boxName: 'security_tokenE', key: 'token');

  const DbConstants({required this.key, this.boxName = 'tokenE'});

  final String key;
  final String boxName;
}
