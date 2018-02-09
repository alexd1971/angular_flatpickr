# AngularDart flatpickr

This is an angulardart wrapper of JS [flatpickr][flatpickr] -- simple but powerful date/time picker

## Usage

A simple usage example:

```dart
import 'package:angular/angular.dart';
import 'package:angular_flatpickr/angular_flatpickr.dart';

@Component(
  selector: 'my-component',
  template: '''
    <input  type=text
            flatpickr
            fp-locale="ru"
            [fp-default-date]="defaultDate"
            fp-date-format="d.m.Y H:i:S"
            [fp-disable]="disable"
            fp-enable-time=true
            fp-time24hr=true
            (fp-onchange)="onChange($event)"
            (fp-onopen)="onOpen()"
            (fp-onclose)="onClose()"
            (fp-onready)="onReady()"
            #fp="FlatPickr">

    <button (click)="onButtonClick()">Click me</button>
  '''
)
class MyComponent {
  /// Initial date and time
  DateTime defaultDate = new DateTime(2018, DateTime.FEBRUARY, 1) ;

  /// Max date available
  DateTime maxDate = new DateTime(2018,DateTime.FEBRUARY, 20);

  /// List of disabled dates
  ///
  /// Dates can be set in different ways:
  /// - DateTime object
  /// - date string
  /// - Map setting date range
  /// - function getting DateTime object as its arguments and returning bool result
  List disable = [

    new DateTime(2018, DateTime.FEBRUARY, 28),

    '2018-02 10',

    (DateTime date) {
      return date.day == 15;
    },

    {
      'from': '2018-02-20',
      'to': '2018-02-25'
    }
  ];
  
  /// This function executes when date/time picker changes its value
  void onChange(List<DateTime> dates) {
    print(dates);
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
  
  // It is possible to get controller instance...
  @ViewChild('fp')
  FlatPickr fp;
  
  void onButtonClick() {
    // ... and use it later
    print(fp.selectedDates);
  }
}
```
There are more options and methods to control flatpickr. You can get additional information in source

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/alexd1971/angular_flatpickr/issues
[flatpickr]: https://chmln.github.io/flatpickr/
