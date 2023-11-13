import 'package:ngdart/angular.dart';
import 'package:ngrouter/ngrouter.dart';
import 'package:angular_app/app_component.template.dart' as ng;
import 'package:angular_app/in_memory_data_service.dart';
import 'package:http/http.dart';

import 'main.template.dart' as self;

@GenerateInjector([
  routerProvidersHash,
  ClassProvider(Client, useClass: InMemoryDataService),
])
final InjectorFactory injector = self.injector$Injector;

void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}
