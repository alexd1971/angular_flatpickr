@TestOn('browser')

import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:pageloader/objects.dart';
import 'package:test/test.dart';

import 'package:angular_flatpickr/angular_flatpickr.dart';

@Component(
    selector: 'test',
    template: '''
  <form>
    <input
      type="text"
      flatpickr
      [(ngModel)]="selectedDate"
    >
    <button>Close calendar</button>
  </form>
  ''',
    directives: const [formDirectives, flatpickrDirectives])
class TestComponent {
  DateTime selectedDate;
}

class TestPO {
  @ByTagName('input')
  PageLoaderElement _input;

  @ByTagName('button')
  PageLoaderElement _button;

  Future<bool> get readOnly async {
    return await _input.attributes['readonly'] == 'readonly';
  }

  Future<bool> get hasFlatpikrClass async {
    await for (String cls in _input.classes) {
      if (cls == 'flatpickr-input') return true;
    }
    return false;
  }

  Future openCalendarWithClick() => _input.click();
  Future openCalendarWithFocus() => _input.focus();
  Future closeCalendar() => _button.click();
  Future<String> get dateString => _input.properties['value'];
}

@AngularEntrypoint()
void main() {
  NgTestFixture<TestComponent> fixture;
  TestPO testPO;

  setUp(() async {
    final testBed = new NgTestBed<TestComponent>();
    fixture = await testBed.create();
    testPO = await fixture.resolvePageObject(TestPO);
  });

  tearDown(disposeAnyRunningTest);

  test('Flatpickr is initialized', () async {
    bool readOnly = await testPO.readOnly;
    bool hasFlatpikrClass = await testPO.hasFlatpikrClass;
    bool calendarInvisible = document.body
            .querySelector('div.flatpickr-calendar')
            .getComputedStyle()
            .visibility ==
        'hidden';
    expect(readOnly && hasFlatpikrClass && calendarInvisible, true);
  });

  test('Click opens calendar', () async {
    await testPO.openCalendarWithClick();
    expect(
        document.body
            .querySelector('div.flatpickr-calendar')
            .getComputedStyle()
            .visibility,
        'visible');
  });

  test('Focus opens calendar', () async {
    await testPO.openCalendarWithFocus();
    expect(
        document.body
            .querySelector('div.flatpickr-calendar')
            .getComputedStyle()
            .visibility,
        'visible');
  });

  test('Calendar closes', () async {
    await testPO.openCalendarWithClick();
    await testPO.closeCalendar();
    expect(
        document.body
            .querySelector('div.flatpickr-calendar')
            .getComputedStyle()
            .visibility,
        'hidden');
  });

  test('Initial date set via ngModel binding', () async {
    fixture.assertOnlyInstance.selectedDate = new DateTime.now();
    await fixture.update();
    expect(
        await testPO.dateString, new DateTime.now().toString().split(' ')[0]);
  });

  test('User interaction changes the selected date', () async {
    await testPO.openCalendarWithClick();
    Element days = document.body.querySelector('div.dayContainer');
    DateTime todayDate = new DateTime.now();
    Element todayElement = days.children
        .firstWhere((Element el) => el.text == todayDate.day.toString());
    todayElement.dispatchEvent(new MouseEvent('mousedown'));
    await fixture.update();
    String actualDateString =
        fixture.assertOnlyInstance.selectedDate.toString().split(' ')[0];
    String expectedDateString = todayDate.toString().split(' ')[0];
    expect(actualDateString, equals(expectedDateString));
  });
}
