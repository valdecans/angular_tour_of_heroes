import 'package:ngdart/angular.dart';
import 'package:ngforms/ngforms.dart';
import 'src/hero.dart';
import 'src/mock_heroes.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  styleUrls: ['app_component.css'],
  directives: [coreDirectives, formDirectives],
)
class AppComponent {
  final title = 'Viagem dos Heróis';
  List<Hero> heroes = mockHeroes;
  Hero? selected;

  void onSelect(Hero hero) => selected = hero;
}
