// Copyright (с) 2018 Aleksey Danilevskiy<alexey.danilevsky@gmail.com>
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

@JS()
library flatpickr;

import 'dart:html';
import 'dart:js';
import 'package:js/js.dart';

external FlatpickrJs flatpickr(element, FpConfigJs options);

@JS('flatpickr')
class FP {
  /// Parses date string according to date format
  ///
  /// Returns JS Date object
  external static JsObject parseDate(String dateStr, String dateFormat);

  /// Transforms JS date object to string according to date format
  ///
  /// Returns formatted string
  external static String formatDate(JsObject dateObj, String dateFormat);
}

@JS()
@anonymous
class FlatpickrJs {
  /// The text input element associated with flatpickr.
  external HtmlElement get input;

  /// Self-explanatory. This is the div.flatpickr-calendar element.
  external HtmlElement get calendarContainer;

  /// The “left arrow” element responsible for decrementing the current month.
  external HtmlElement get prevMonthNav;

  /// The “right arrow” element responsible for incrementing the current month.
  external HtmlElement get nextMonthNav;

  /// The span holding the current month’s name.
  external HtmlElement get currentMonthElement;

  /// The input holding the current year.
  external HtmlElement get currentYearElement;

  /// The container for all the day elements.
  external HtmlElement get days;

  /// The array of selected dates (Date objects).
  external List get selectedDates;

  /// The year currently displayed on the calendar.
  external int get currentYear;

  /// The zero-indexed month number (0-11) currently displayed on the calendar.
  external int get currentMonth;

  /// The configuration object (defaults + user-specified options).
  external FpConfigJs get config;

  /// Changes the current month
  external void changeMonth(int monthNum, [bool isOffset = true]);

  /// Resets the selected dates (if any) and clears the input.
  external void clear();

  /// Resets the selected dates (if any) and clears the input.
  external void close();

  /// Destroys the flatpickr instance, cleans up - removes event listeners,
  /// restores inputs, etc.
  external void destroy();

  /// Returns a string representation of dateObj,  formatted as per formatStr
  external String formatDate(JsObject dateObj, String formatStr);

  /// Sets the calendar view to the year and month of date, which can be a date
  /// string, a Date, or nothing.
  ///
  /// If date is undefined, the view is set to the latest selected date,
  /// the minDate, or today’s date
  external void jumpToDate(date);

  /// Shows/opens the calendar.
  external void open();

  /// Parses a date string or a timestamp, and returns a Date.
  external JsObject parseDate(String dateStr, [String dateFormat]);

  /// Redraws the calendar. Shouldn’t be necessary in most cases.
  external void redraw();

  /// Sets a config option optionto value, redrawing the calendar and updating
  /// the current view, if necessary.
  external void set(String option, value);

  /// Sets the current selected date(s) todate, which can be a date string, a Date,
  /// or anArray of the Dates.
  ///
  ///Optionally, pass true as the second argument to force any onChange events
  /// to fire. And if you’re passing a date string with a format other than your
  /// dateFormat, provide a dateStrFormat e.g. "m/d/Y".
  external void setDate(date,
      [bool triggerChange = false, String dateStrFormat]);

  /// Shows/opens the calendar if its closed, hides/closes it otherwise.
  external void toggle();
}

/// Type for flatpickr event handler
typedef OnPickrJsEvent(
    List<JsObject> selectedDates, String dateStr, FlatpickrJs instance, e);

/// FlatpickrJS configuration options
@JS()
@anonymous
class FpConfigJs {
  /// Exactly the same as [dateFormat], but for the [altInput] field
  ///
  /// Default: `"F j, Y"`
  external String get altFormat;
  external set altFormat(String v);

  /// Show the user a readable date (as per [altFormat]), but return something
  /// totally different to the server.
  ///
  /// Default: `false`
  external bool get altInput;
  external set altInput(bool v);

  /// This class will be added to the input element created by the [altInput]
  /// option.  Note that [altInput] already inherits classes from the original
  /// input.
  ///
  /// Default: `""`
  external String get altInputClass;
  external set altInputClass(String v);

  /// Allows the user to enter a date directly input the input field. By default,
  /// direct entry is disabled.
  ///
  /// Default: `false`
  external bool get allowInput;
  external set allowInput(bool v);

  /// Instead of body, appends the calendar to the specified node.
  ///
  /// Default: `null`
  external HtmlElement get appendTo;
  external set appendTo(HtmlElement v);

  /// Defines how the date will be formatted in the aria-label for calendar days,
  /// using the same tokens as [dateFormat]. If you change this, you should choose
  /// a value that will make sense if a screen reader reads it out loud.
  ///
  /// Default: `"F j, Y"`
  external String get ariaDateFormat;
  external set ariaDateFormat(String v);

  /// Whether clicking on the input should open the picker. You could disable
  /// this if you wish to open the calendar manually with open()
  ///
  /// Default: `true`
  external bool get clickOpens;
  external set clickOpens(bool v);

  /// A string of characters which are used to define how the date will be displayed in the input box.
  ///
  /// # The supported characters:
  ///
  /// ## Date Formatting Tokens:
  ///
  ///     |   | Description                                          | Example                  |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | d | Day of the month, 2 digits with leading zeros        | 01 to 31                 |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | D | A textual representation of a day	Mon through        | Sun                      |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | l | A full textual representation of the day of the week | Sunday - Saturday        |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | j | Day of the month without leading zeros               | 1 to 31                  |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | J | Day of the month without leading zeros and ordinal   | 1st, 2nd, to 31st        |
  ///     |   | suffix                                               |                          |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | w | Numeric representation of the day of the week        | 0 (for Sunday) -         |
  ///     |   |                                                      | 6 (for Saturday)         |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | F | A full textual representation of a month             | January - December       |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | m | Numeric representation of a month, with leading zero | 01 - 12                  |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | n | Numeric representation of a month, without leading   | 1 - 12                   |
  ///     |   | zeros                                                |                          |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | M | A short textual representation of a month            | Jan - Dec                |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | U | The number of seconds since the Unix Epoch           | 1413704993               |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | y | A two digit representation of a year                 | 99 or 03                 |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | Y | A full numeric representation of a year, 4 digits    | 1999 or 2003             |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | Z | ISO Date format                                      | 2017-03-04T01:23:43.000Z |
  ///
  /// ## Time Formatting Tokens:
  ///
  ///     |   | Description                                          | Example                  |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | H | Hours (24 hours)	                                   | 00 to 23                 |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | h | Hours                                                | 1 to 12                  |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | i | Minutes                                              | 00 to 59                 |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | S | Seconds, 2 digits                                    | 00 to 59                 |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | s | Seconds                                              | 0, 1 to 59               |
  ///     | - | -----------------------------------------------------| ------------------------ |
  ///     | K | AM/PM                                                | AM or PM                 |
  ///
  /// Default: `"Y-m-d"`
  external String get dateFormat;
  external set dateFormat(String v);

  /// Initial selected date(s).
  ///
  /// If you're using mode: "multiple" or a range calendar supply an Array of
  /// Date objects or an Array of date strings which follow your dateFormat.
  /// Otherwise, you can supply a single Date object or a date string.
  ///
  /// Default: `null`
  external dynamic get defaultDate;
  external set defaultDate(dynamic v);

  /// Initial value of the hour element.
  ///
  /// Default: `12`
  external int get defaultHour;
  external set defaultHour(int v);

  /// Initial value of the minute element.
  ///
  /// Default: `0`
  external int get defaultMinute;
  external set defaultMinute(int v);

  /// Dates unavailable for selection.
  ///
  /// There are multiple methods of doing so.
  ///
  /// ## Disabling certain dates:
  ///
  ///     disable: ["2025-01-30", "2025-02-21", "2025-03-08", new Date(2025, 4, 9) ]
  ///
  /// ## Disabling date ranges:
  ///
  ///     disable: [
  ///       {
  ///         from: "2025-04-01",
  ///         to: "2025-05-01"
  ///       },
  ///       {
  ///         from: "2025-09-01",
  ///         to: "2025-12-01"
  ///       }
  ///     ]
  ///
  /// ## Disabling dates by function:
  ///
  ///     disable: [
  ///       function(date) {
  ///         // return true to disable
  ///         return (date.getDay() === 5 || date.getDay() === 6);
  ///
  ///       }
  ///     ]
  ///
  /// Default: `[]`
  external List get disable;
  external set disable(List v);

  /// Set disableMobile to true to always use the non-native picker.
  /// By default, flatpickr utilizes native datetime widgets unless certain
  /// options (e.g. disable) are used.
  ///
  /// Default: `false`
  external bool get disableMobile;
  external set disableMobile(bool v);

  /// Dates avalable for selection
  ///
  /// This is the enable option, which takes in an array of date strings, date
  /// ranges and functions. Essentially the same as the [disable] option above,
  /// but reversed.
  ///
  /// Default: `[]`
  external List get enable;
  external set enable(List v);

  /// Enables time picker
  ///
  /// Default: `false`
  external bool get enableTime;
  external set enableTime(bool v);

  /// Enables seconds in the time picker.
  ///
  /// Default: `false`
  external bool get enableSeconds;
  external set enableSeconds(bool v);

  /// Allows using a custom date formatting function instead of the built-in.
  ///
  /// Handling for date formats using dateFormat, altFormat, etc.
  ///
  /// Default: `null`
  external Function get formatDate;
  external set formatDate(Function v);

  /// Adjusts the step for the hour input (incl. scrolling)
  ///
  /// Default: `1`
  external int get hourIncrement;
  external set hourIncrement(int v);

  /// Displays the calendar inline
  ///
  /// Default: `false`
  external bool get inline;
  external set inline(bool v);

  /// Locale string
  ///
  /// The locale js-file must be loaded
  /// More info: https://chmln.github.io/flatpickr/localization/
  ///
  /// Default: `en`
  external String get locale;
  external set locale(String v);

  /// The maximum date that a user can pick to (inclusive).
  ///
  /// Default: `null`
  external dynamic /*String|Date*/ get maxDate;
  external set maxDate(dynamic v);

  /// The minimum date that a user can start picking from (inclusive).
  ///
  /// Default: `null`
  external dynamic /*String|Date*/ get minDate;
  external set minDate(dynamic v);

  /// Adjusts the step for the minute input (incl. scrolling)
  ///
  /// Default: `5`
  external int get minuteIncrement;
  external set minuteIncrement(int v);

  /// "single", "multiple", or "range"
  ///
  /// Default: `"single"`
  external String get mode;
  external set mode(String v);

  /// HTML for the arrow icon, used to switch months.
  ///
  /// Default: `>`
  external String get nextArrow;
  external set nextArrow(String v);

  /// Hides the day selection in calendar.
  ///
  /// Use it along with enableTime to create a time picker.
  ///
  /// Default: `false`
  external bool get noCalendar;
  external set noCalendar(bool v);

  /// Function(s) to trigger on every date selection
  ///
  /// Description: https://chmln.github.io/flatpickr/events/#onchange
  ///
  /// Default: `null`
  external List<OnPickrJsEvent> get onChange;
  external set onChange(List<OnPickrJsEvent> v);

  /// Function(s) to trigger on every time the calendar is closed.
  ///
  /// Description: https://chmln.github.io/flatpickr/events/#onclose
  ///
  /// Default: `null`
  external List<OnPickrJsEvent> get onClose;
  external set onClose(List<OnPickrJsEvent> v);

  /// Function(s) to trigger on every time the calendar is opened.
  ///
  /// Description: https://chmln.github.io/flatpickr/events/#onopen
  ///
  /// Default: `null`
  external List<OnPickrJsEvent> get onOpen;
  external set onOpen(List<OnPickrJsEvent> v);

  /// Function to trigger when the calendar is ready.
  ///
  /// Description: https://chmln.github.io/flatpickr/events/#onready
  ///
  /// Default: `null`
  external List<OnPickrJsEvent> get onReady;
  external set onReady(List<OnPickrJsEvent> v);

  /// Function that expects a date string and must return a Date object
  ///
  /// Default: `null`
  external /*Date*/ Function /*(String dateString)*/ get parseDate;
  external set parseDate(Function v);

  /// HTML for the left arrow icon.
  ///
  /// Default: `<`
  external String get prevArrow;
  external set prevArrow(String v);

  /// Show the month using the shorthand version (ie, Sep instead of September).
  ///
  /// Default: `false`
  external bool get shorthandCurrentMonth;
  external set shorthandCurrentMonth(bool v);

  /// Position the calendar inside the wrapper and next to the input element.
  ///
  /// Leave `false` unless you know what you're doing.
  ///
  /// Default: `false`
  external bool get static;
  external set static(bool v);

  /// Displays time picker in 24 hour mode without AM/PM selection when enabled.
  ///
  /// Default: `false`
  external bool get time_24hr;
  external set time_24hr(bool v);

  /// Enables display of week numbers in calendar.
  ///
  /// Default: `false`
  external bool get weekNumbers;
  external set weekNumbers(bool v);

  /// This permits additional markup, as well as custom elements to trigger the
  /// state of the calendar.
  ///
  /// flatpickr can parse an input group of textboxes and buttons, common in Bootstrap and other frameworks.
  ///
  ///     <div class=flatpickr>
  ///       <input type="text" placeholder="Select Date.." data-input> <!-- input is mandatory -->
  ///
  ///       <a class="input-button" title="toggle" data-toggle>
  ///         <i class="icon-calendar"></i>
  ///       </a>
  ///
  ///       <a class="input-button" title="clear" data-clear>
  ///         <i class="icon-close"></i>
  ///       </a>
  ///     </div>
  ///
  /// Default: `false`
  external bool get wrap;
  external set wrap(bool v);

  external factory FpConfigJs(
      {String altFormat = 'F j, Y',
      bool altInput = false,
      String altInputClass = '',
      bool allowInput = false,
      HtmlElement appendTo,
      String ariaDateFormat = 'F j, Y',
      bool clickOpens = true,
      String dateFormat = 'Y-m-d',
      dynamic defaultDate,
      int defaultHour = 12,
      int defaultMinute = 0,
      List disable = const [],
      bool disableMobile = false,
      List enable = const [],
      bool enableTime = false,
      bool enableSeconds = false,
      Function formatDate,
      int hourIncrement = 1,
      bool inline = false,
      String locale = 'en',
      dynamic maxDate,
      dynamic minDate,
      int minuteIncrement = 5,
      String mode = 'single',
      String nextArrow = '>',
      bool noCalendar = false,
      dynamic onChange,
      dynamic onClose,
      dynamic onOpen,
      dynamic onReady,
      Function parseDate,
      String prevArrow = '<',
      bool shorthandCurrentMonth = false,
      bool static = false,
      bool time_24hr = false,
      bool weekNumbers = false,
      bool wrap = false});
}
