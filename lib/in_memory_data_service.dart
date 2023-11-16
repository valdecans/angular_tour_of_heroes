import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'src/hero.dart';

class InMemoryDataService extends MockClient {
  static final _initialHeroes = [
    {'id': 11, 'name': 'Achilles'},
    {'id': 12, 'name': 'Cadmus'},
    {'id': 13, 'name': 'Diomedes'},
    {'id': 14, 'name': 'Heracles'},
    {'id': 15, 'name': 'Icarus'},
    {'id': 16, 'name': 'Meleager'},
    {'id': 17, 'name': 'Orpheus'},
    {'id': 18, 'name': 'Perseus'},
    {'id': 19, 'name': 'Theseus'},
    {'id': 20, 'name': 'Zeus'},
    {'id': 21, 'name': 'Poseidon'},
    {'id': 22, 'name': 'Hera'},
    {'id': 23, 'name': 'Atena'},
    {'id': 24, 'name': 'Ares'},
    {'id': 25, 'name': 'Apolo'},
  ];

  static late List<Hero> _heroesDb;
  static late int _nextId;

  static Future<Response> _handler(Request request) async {
    var data;

    switch(request.method) {
      case 'GET':
        final id = int.tryParse(request.url.pathSegments.last);
        if(id != null) {
          data = _heroesDb.firstWhere((hero) => hero.id == id);
        } else {
          String prefix = request.url.queryParameters['name'] ?? '';
          final regExp = RegExp(prefix, caseSensitive: false);
          data = _heroesDb.where((hero) => hero.name.contains(regExp)).toList();
        }
        break;
      case 'POST':
        var name = json.decode(request.body)['name'];
        var newHero = Hero(_nextId++, name);
        _heroesDb.add(newHero);
        data = newHero;
        break;
      case 'PUT':
        var heroChanges = Hero.fromJson(json.decode(request.body));
        var targetHero = _heroesDb.firstWhere((h) => h.id == heroChanges.id);
        targetHero.name = heroChanges.name;
        data = targetHero;
        break;
      case 'DELETE':
        var id = int.parse(request.url.pathSegments.last);
        _heroesDb.removeWhere((hero) => hero.id == id);
        break;
      default:
      throw 'Unimplemented HTTP method ${request.method}';
    }
    return Response(json.encode({'data': data}), 200,
      headers: {'contant-type': 'application/json'});
  }

  static void resetDb() {
    _heroesDb = _initialHeroes.map((json) => Hero.fromJson(json)).toList();
    _nextId = _heroesDb.map((hero) => hero.id).fold(0, max) + 1;
  }

  static String lookUpName(int id) =>
      _heroesDb.firstWhere((hero) => hero.id == id, orElse: null).name;

  InMemoryDataService() : super(_handler) {
    resetDb();
  }
}