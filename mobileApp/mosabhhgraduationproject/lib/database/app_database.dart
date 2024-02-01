import 'package:postgres/postgres.dart';

class AppDatabase {

  AppDatabase._();

  static AppDatabase? _instance;
  Connection? _conn;

  Endpoint get endpoint => Endpoint(
    host: '10.0.2.2',
    port: 5432,
    database: 'MOSABDB',
    username: 'postgres',
    password: '0000',
  );


  factory AppDatabase.instance() {
    _instance ??= AppDatabase._();
    return _instance!;
  }

  Future<Connection?> getConnectionInstance() async {
    if (_conn == null || _conn!.closed == true) {
      _conn = await Connection.open(endpoint, settings: const ConnectionSettings(sslMode: SslMode.disable));
    }

    return _conn;
  }
}