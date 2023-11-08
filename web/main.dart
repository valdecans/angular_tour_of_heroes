import 'package:ngdart/angular.dart';
import 'package:ngrouter/ngrouter.dart';
import 'package:angular_app/app_component.template.dart' as ng;

import 'main.template.dart' as self;

@GenerateInjector(
  routerProvidersHash,
)
final InjectorFactory injector = self.injector$Injector;
void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}
