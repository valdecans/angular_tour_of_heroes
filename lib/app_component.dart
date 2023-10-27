import 'package:ngdart/angular.dart';
import 'package:ngforms/ngforms.dart';
import 'src/hero.dart';
import 'src/mock_heroes.dart';
import 'src/hero_component.dart';
import 'src/hero_service.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  styleUrls: ['app_component.css'],
  directives: [coreDirectives, HeroComponent],
  providers: [ClassProvider(HeroService)],
)
class AppComponent implements OnInit {
  final title = 'Viagem dos Heróis';
  Hero? selected;

  List<Hero> heroes = <Hero>[];
  Future<void> _getHeroes() async {
    heroes = await _heroService.getAllSlowly();
  }

  final HeroService _heroService;
  AppComponent(this._heroService);

  void onSelect(Hero hero) => selected = hero;
  void ngOnInit() => _getHeroes();
}