import 'dart:async';

import 'package:ngdart/angular.dart';
import 'package:ngrouter/ngrouter.dart';
import 'package:stream_transform/stream_transform.dart';

import 'route_paths.dart';
import 'hero_search_service.dart';
import 'hero.dart';

@Component(
  selector: 'hero-search',
  templateUrl: 'hero_search_component.html',
  styleUrls: ['hero_search_component.css'],
  directives: [coreDirectives],
  providers: [ClassProvider(HeroSearchService)],
  pipes: [commonPipes],
)
class HeroSearchComponent implements OnInit {
  HeroSearchService _heroSearchService;
  Router _router;

  late Stream<List<Hero>> heroes;
  StreamController<String> _searchTerms = StreamController<String>.broadcast();

  HeroSearchComponent(this._heroSearchService, this._router) {}

  void search(String term) => _searchTerms.add(term);

  void ngOnInit() async {
    heroes = _searchTerms.stream
      .debounce(Duration(milliseconds: 300))
      .distinct()
      .switchMap((term) => term.isEmpty
        ? Stream<List<Hero>>.fromIterable([<Hero>[]])
        : _heroSearchService.search(term).asStream())
      .handleError((e) {
        print(e);
    });
  }

  String _heroUrl(int id) =>
    RoutePaths.hero.toUrl(parameters: {idParam: '$id'});

  Future<NavigationResult> gotoDetail(Hero hero) =>
    _router.navigate(_heroUrl(hero.id));
}