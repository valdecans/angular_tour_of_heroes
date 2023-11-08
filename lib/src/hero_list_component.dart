import 'package:ngdart/angular.dart';
import 'package:ngforms/ngforms.dart';
import 'hero.dart';
import 'mock_heroes.dart';
import 'hero_component.dart';
import 'hero_service.dart';

@Component(
  selector: 'my-heroes',
  templateUrl: 'hero_list_component.html',
  styleUrls: ['hero_list_component.css'],
  directives: [coreDirectives, HeroComponent],
)
class HeroListComponent implements OnInit {
  Hero? selected;

  List<Hero> heroes = <Hero>[];
  Future<void> _getHeroes() async {
    heroes = await _heroService.getAllSlowly();
  }
  final HeroService _heroService;

  HeroListComponent(this._heroService);

  void onSelect(Hero hero) => selected = hero;
  void ngOnInit() => _getHeroes();
}