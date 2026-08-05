import 'package:flutter_test/flutter_test.dart';
import 'package:stopcorn/app/app_routes.dart';

/// Runs centralized application-route tests.
void main() {
  test('builds an encoded module route', () {
    expect(AppRoutes.module('module with space'), '/module/module%20with%20space');
  });

  test('builds a linked consumption route without manual concatenation', () {
    expect(
      AppRoutes.logConsumptionFor('session/id'),
      '/log-consumption?urgeSessionId=session%2Fid',
    );
    expect(AppRoutes.logConsumptionFor(null), AppRoutes.logConsumption);
  });

  test('places the initial profile under progress', () {
    expect(AppRoutes.initialProfile, startsWith('${AppRoutes.progress}/'));
  });
}
