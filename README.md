# Angular Dart date/time picker

This is an Angular Dart wrapper of javascript library [flatpickr][flatpickr] -- simple but powerful date/time picker

## Usage

First of all you need to add some resources in your index.html file:

```html
<!-- Main flatpick js-library -->
<script src="https://npmcdn.com/flatpickr/dist/flatpickr.min.js"></script>
<!-- Your locale file -->
<script src="https://npmcdn.com/flatpickr/dist/l10n/ru.js"></script>
<!-- flatpickr styles -->
<link rel="stylesheet" href="https://npmcdn.com/flatpickr/dist/flatpickr.min.css">
```

A simple usage example:

```dart
import 'package:angular/angular.dart';
import 'package:angular_flatpickr/angular_flatpickr.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'my-component',
  template: '''
    <form ngSubmit="onSubmit()">
      <input  type=text flatpickr
        [(ngModel)]="selectedDate"
        fpLocale="ru"
        [fpDefaultDate]="defaultDate"
        fpDateFormat="d.m.Y H:i:S"
        fpEnableTime=true
        fpTime24hr=true
        (fpOnChange)="onChange($event)"
        (fpOnOpen)="onOpen()"
        (fpOnClose)="onClose()"
        (fpOnReady)="onReady()">

      <input type="submit value="Submit">
    </form>
  ''',
  directives: const [
    formDirectives,
    flatpickrDirectives
  ]
)
class MyComponent {

  /// Initial date and time
  DateTime defaultDate = new DateTime.now();
  // Initial date and time can be set in different way:
  // DateTime selectedDate = new DateTime.now();
  
  /// This function executes when date/time picker changes its value
  void onChange(FlatpickrChangeEvent event) {
    print('New value: ${event.value}');
  }
  
  /// This function executes when calendar opens
  void onOpen() {
    print("Open");
  }
  
  /// This function executes when calendar closes
  void onClose() {
    print("Close");
  }
  
  /// This function execute after flatpickr initialization
  void onReady() {
    print("Ready");
  }

  /// Selected date
  DateTime selectedDate;
  
  void onSubmit() {
    print('Selected date: $selectedDate');
  }
}
```

There are more options and methods to control flatpickr. You can get more information in documentation

More advanced example see in examples.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/alexd1971/angular_flatpickr/issues
[flatpickr]: https://chmln.github.io/flatpickr/
