import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import 'package:angular_flatpickr/angular_flatpickr.dart';

@Component(
    selector: 'my-app',
    template: '''
    <h1>Angular Dart Date/Time Picker Demo</h1>
    <form #f="ngForm" (ngSubmit)="onSubmit(f)">
      <div>
        <input type=text
          required
          flatpickr
          [(ngModel)]="selectedDate"
          #date="ngForm"
          ngControl="date"
          fpLocale="en"
          fpDateFormat="d.m.Y H:i"
          fpEnableTime=true
          fpTime24hr=true
          [fpDisable]="disable"
          (fpOnReady)="onReady()"
          (fpOnChange)="onChange(\$event)"
          (fpOnOpen)="onOpen()"
          (fpOnClose)="onClose()"
          #fp="flatpickr">
      </div>
      <div>
        <span [ngClass]="{'valid':date.valid, 'invalid':!date.valid}">
          {{date.valid ? 'The field is valid' : 'The field is invalid'}}
        </span>
      </div>
        <input type="submit" value="Submit">
    </form>
    <button (click)="openCalendar()">Open Calendar manually"</button>
    <pre>{{data}}</pre> 
  ''',
    styles: const [
      ''':host input {
        font-size: large;
    },
    :host span {
        font-size: small;
    },
    :host span.valid {
        color: green;
    },
    :host span.invalid {
        color: red;
    }'''
    ],
    directives: const [
      formDirectives,
      flatpickrDirectives
    ])
class AppComponent {
  /// List of disabled dates
  ///
  /// Dates can be set in different ways:
  /// - DateTime object
  /// - date string
  /// - Map setting date range
  /// - function getting DateTime object as its arguments and returning bool result
  List disable = [
    new DateTime(2018, DateTime.FEBRUARY, 28),
    '10.02.2018',
    (DateTime date) {
      return date.day == 15;
    },
    {'from': '20.02.2018', 'to': '25.02.2018'}
  ];

  /// This function executes when date/time picker changes its value
  void onChange(FlatpickrChangeEvent event) {
    print(event.value);
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

  /// Date selected in flatpickr
  DateTime selectedDate = new DateTime.now();

  /// Form data
  String data;

  /// Flatpickr controller instance
  @ViewChild('fp')
  Flatpickr fp;

  /// Handles form submit
  void onSubmit(NgForm form) {
    print(selectedDate);
    if (form.valid) {
      data = JSON.encode(form.value, toEncodable: (value) {
        return value.toString();
      });
    } else {
      selectedDate = new DateTime.now();
      data = 'Form is invalid. Can\'t submit';
    }
  }

  /// Opens calendar
  void openCalendar() {
    fp.open();
  }
}
