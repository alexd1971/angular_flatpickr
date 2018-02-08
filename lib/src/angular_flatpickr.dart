import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'dart:js_util';
import 'package:angular/angular.dart';
import 'flatpickr.js.dart';

/// FlatPickr component options
/// 
/// Each options described in [FlatPickr] component
class _FpOptions {
    String altFormat = 'F j, Y';
    bool altInput = false;
    String altInputClass = '';
    bool allowInput = false;
    HtmlElement appendTo;
    String ariaDateFormat = 'F j; Y';
    bool clickOpens = true;
    String dateFormat = 'Y-m-d';
    dynamic defaultDate;
    int defaultHour = 12;
    int defaultMinute = 0;
    List disable = const [];
    bool disableMobile = false;
    List enable = const [];
    bool enableTime = false;
    bool enableSeconds = false;
    Function formatDate;
    int hourIncrement = 1;
    bool inline = false;
    String locale = 'en';
    dynamic maxDate;
    dynamic minDate;
    int minuteIncrement = 5;
    String mode = 'single';
    String nextArrow = '>';
    bool noCalendar = false;
    dynamic onChange;
    dynamic onClose;
    dynamic onOpen;
    dynamic onReady;
    Function parseDate;
    String prevArrow = '<';
    bool shorthandCurrentMonth = false;
    bool static = false;
    bool time_24hr = false;
    bool weekNumbers = false;
    bool wrap = false;
}

@Directive(
  selector: '[flatpickr]',
  exportAs: 'FlatPickr'
)
class FlatPickr implements AfterViewInit, OnDestroy{

  /// Configuration options of JS flatpickr object
  final _initialConfig = new FpConfigJs(
    altFormat: 'F j, Y',
    altInput: false,
    altInputClass: '',
    allowInput: false,
    ariaDateFormat: 'F j, Y',
    clickOpens: true,
    dateFormat: 'Y-m-d',
    defaultHour: 12,
    defaultMinute: 0,
    disable: const [],
    disableMobile: false,
    enable: const [],
    enableTime: false,
    enableSeconds: false,
    hourIncrement: 1,
    inline: false,
    locale: 'en',
    minuteIncrement: 5,
    mode: 'single',
    nextArrow: '>',
    noCalendar: false,
    prevArrow: '<',
    shorthandCurrentMonth: false,
    static: false,
    time_24hr: false,
    weekNumbers: false,
    wrap: false
  );

  /// Options of FlatPickr component  
  var _options = new _FpOptions();
  
  HtmlElement _element;

  FlatPickr(HtmlElement element) {
    if(element.hasChildNodes()) {
      _element = element.querySelector('input');
    } else {
      _element = element;
    }
  }

  /// Exactly the same as [dateFormat], but for the [altInput] field
  ///
  /// Default: `"F j, Y"`  
  String get fpAltFormat => _options.altFormat;
  @Input()
  set fpAltFormat(String v) {
    _options.altFormat = v;
    if(_fp == null) {
      _initialConfig.altFormat = v;
    } else {
      _fp.set('altFormat', v);
    }
  }

  /// Show the user a readable date (as per [altFormat]), but return something
  /// totally different to the server.
  ///
  /// Default: `false`
  bool get fpAltInput => _options.altInput;
  @Input()
  set fpAltInput(bool v) {
    _options.altInput = v;
    if(_fp == null) {
      _initialConfig.altInput = v;
    } else {
      window.console.warn('Changing the value of altInput after component initialization has no effect');
    }
  }

  /// This class will be added to the input element created by the [altInput]
  /// option.
  /// 
  /// Note that [altInput] already inherits classes from the original input.
  ///
  /// Default: `""`
  String get fpAltInputClass => _options.altInputClass;
  @Input()
  set fpAltInputClass(String v) {
    _options.altInputClass = v;
    if(_fp == null) {
      _initialConfig.altInputClass = v;
    } else {
      window.console.warn('Changing the value of altInputClass after component initialization has no effect');
    }
  }

  /// Allows the user to enter a date directly in the input field.
  /// 
  /// By default, direct entry is disabled.
  ///
  /// Default: `false`
  bool get fpAllowInput => _options.allowInput;
  @Input()
  set fpAllowInput(bool v) {
    _options.allowInput = v;
    if(_fp == null) {
      _initialConfig.allowInput = v;
    } else {
      window.console.warn('Changing the value of allowInput after component initialization has no effect');
    }
  }

  /// Instead of body, appends the calendar to the specified node.
  ///
  /// Default: `null`
  HtmlElement get fpAppendTo => _options.appendTo;
  @Input()
  set fpAppendTo(HtmlElement v) {
    _options.appendTo = v;
    if(_fp == null) {
      _initialConfig.appendTo = v;
    } else {
      window.console.warn('Changing the value of appendTo after component initialization has no effect');
    }
  }

  /// Defines how the date will be formatted in the aria-label for calendar days.
  /// 
  /// Uses the same tokens as [dateFormat]. If you change this, you should choose
  /// a value that will make sense if a screen reader reads it out loud.
  ///
  /// Default: `"F j, Y"`
  String get fpAriaDateFormat => _options.ariaDateFormat;
  @Input()
  set fpAriaDateFormat(String v) {
    _options.ariaDateFormat = v;
    if(_fp == null) {
      _initialConfig.ariaDateFormat = v;
    } else {
      window.console.warn('Changing the value of ariaDateFormat after component initialization has no effect');
    }
  }

  /// Whether clicking on the input should open the picker.
  /// 
  /// You could disable this if you wish to open the calendar manually with open()
  ///
  /// Default: `true`
  bool get fpClickOpens => _options.clickOpens;
  @Input()
  set fpClickOpens(bool v) {
    _options.clickOpens = v;
    if(_fp == null) {
      _initialConfig.clickOpens = v;
    } else {
      window.console.warn('Changing the value of clickOpens after component initialization has no effect');
    }
  }

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
  String get fpDateFormat => _options.dateFormat;
  @Input()
  set fpDateFormat(String v) {
    _options.dateFormat = v;
    if(_fp == null) {
      _initialConfig.dateFormat = v;
    } else {
      _fp.set('dateFormat', v);
    }
  }

  /// Initial selected date(s).
  ///
  /// If you're using mode: "multiple" or a range calendar supply an `List<DateTime>` or
  /// a `List<String>` which follow your [dateFormat].
  /// Otherwise, you can supply a single [DateTime] object or a date string.
  ///
  /// Default: `null`
  dynamic get fpDefaultDate => _options.defaultDate;
  @Input()
  set fpDefaultDate(dynamic v) {
    _options.defaultDate = v;
    var jsValue;
    if(v is List<DateTime>) {
      jsValue = v.map((date) {return _dateTime2JsDate(date);}).toList();
    } else if(v is List<String> || v is String) {
      jsValue = v;
    } else if(v is DateTime) {
      jsValue = _dateTime2JsDate(v);
    } else {
      throw(new ArgumentError('dafaultDate can be of type DateTime, String, List<DateTime>'
                              ' or List<String>. ${v.runtimeType} given.'));
    }
    if(_fp == null) {
      _initialConfig.defaultDate = jsValue;
    } else {
      window.console.warn('It has no sense to set defaultDate after component initialization');
    }
  }

  /// Initial value of the hour element.
  ///
  /// Default: `12`
  int get fpDefaultHour => _options.defaultHour;
  @Input()
  set fpDefaultHour(int v) {
    _options.defaultHour = v;
    if(_fp == null) {
      _initialConfig.defaultHour = v;
    } else {
      window.console.warn('It has no sense to set defaultHour after component initialization');
    }
  }

  /// Initial value of the minute element.
  ///
  /// Default: `0`
  int get fpDefaultMinute => _options.defaultMinute;
  @Input()
  set fpDefaultMinute(int v) {
    _options.defaultMinute = v;
    if(_fp == null) {
      _initialConfig.defaultMinute = v;
    } else {
      window.console.warn('It has no sense to set defaultMinute after component initialization');
    }
  }

  /// Dates unavailable for selection.
  ///
  /// There are multiple methods of doing so.
  /// 
  /// ## Disabling certain dates:
  /// 
  ///     disable: ["2025-01-30", "2025-02-21", "2025-03-08", new DateTime(2025, 4, 9)]
  ///
  /// ## Disabling date ranges:
  /// 
  ///     disable: [
  ///       {
  ///         'from': '2025-04-01',
  ///         'to': '2025-05-01'
  ///       },
  ///       {
  ///         'from': '2025-09-01',
  ///         'to': '2025-12-01'
  ///       }
  ///     ]
  ///
  /// ## Disabling dates by function:
  /// 
  ///     disable: [
  ///       (DateTime date) {
  ///         // return true to disable
  ///         return (date.day === 5 || date.day === 6);
  ///       }
  ///     ]
  ///
  /// Default: `[]`  List get disable => _options.disable;
  @Input()
  set fpDisable(List v) {
    _options.disable = v;
    var jsValue = v.map((item) {
      if(item is DateTime) {
        return _dateTime2JsDate(item);
      } else if ( item is String) {
        return item;
      } else if (item is Map) {
        return jsify(item);
      } else if (item is Function) {
        return allowInterop((JsObject dateObj) {
          return item(_jsDate2DateTime(dateObj));
        });
      } else {
        throw(new ArgumentError('Items of disable list can be of type DateTime, String, Map'
                                'or Function. ${item.runtimeType} given.'));
      }
    }).toList();
    if(_fp == null) {
      _initialConfig.disable = jsValue;
    } else {
      _fp.set('disable', jsValue);
    }
  }

  /// Set disableMobile to true to always use the non-native picker.
  /// 
  /// By default, flatpickr utilizes native datetime widgets unless certain
  /// options (e.g. disable) are used.
  ///
  /// Default: `false`
  bool get fpDisableMobile => _options.disableMobile;
  @Input()
  set fpDisableMobile(bool v) {
    _options.disableMobile = v;
    if(_fp == null) {
      _initialConfig.disableMobile = v;
    } else {
      _fp.set('disableMobile', v);
    }
  }

  /// Dates avalable for selection
  ///
  /// This is the enable option, which takes in an array of date strings, date
  /// ranges and functions. Essentially the same as the [disable] option above,
  /// but reversed.
  ///
  /// Default: `[]`
  List get fpEnable => _options.enable;
  @Input()
  set enable(List v) {
    _options.enable = v;
    var jsValue = v.map((item) {
      if(item is DateTime) {
        return _dateTime2JsDate(item);
      } else if ( item is String) {
        return item;
      } else if (item is Map) {
        return jsify(item);
      } else if (item is Function) {
        return allowInterop((JsObject dateObj) {
          return item(_jsDate2DateTime(dateObj));
        });
      } else {
        throw(new ArgumentError('Items of enable list can be of type DateTime, String, Map'
                                'or Function. ${item.runtimeType} given.'));
      }
    }).toList();
    if(_fp == null) {
      _initialConfig.enable = jsValue;
    } else {
      _fp.set('enable', jsValue);
    }
  }

  /// Enables time picker
  ///
  /// Default: `false`
  bool get fpEnableTime => _options.enableTime;
  @Input()
  set fpEnableTime(bool v) {
    _options.enableTime = v;
    if(_fp == null) {
      _initialConfig.enableTime = v;
    } else {
      window.console.warn('Changing the value of enableTime after component initialization has no effect');
    }
  }

  /// Enables seconds in the time picker.
  ///
  /// Default: `false`
  bool get fpEnableSeconds => _options.enableSeconds;
  @Input()
  set fpEnableSeconds(bool v) {
    _options.enableSeconds;
    if(_fp == null) {
      _initialConfig.enableSeconds = v;
    } else {
      window.console.warn('Changing the value of enableSeconds after component initialization has no effect');
    }
  }

  /// Adjusts the step for the hour input (incl. scrolling)
  ///
  /// Default: `1`
  int get fpHourIncrement => _options.hourIncrement;
  @Input()
  set fpHourIncrement(int v) {
    _options.hourIncrement = v;
    if(_fp == null) {
      _initialConfig.hourIncrement = v;
    } else {
      window.console.warn('Changing the value of hourIncrement after component initialization has no effect');
    }
  }

  /// Displays the calendar inline
  ///
  /// Default: `false`
  bool get fpInline => _options.inline;
  @Input()
  set fpInline(bool v) {
    _options.inline = v;
    if(_fp == null) {
      _initialConfig.inline = v;
    } else {
      window.console.warn('Changing the value of inline after component initialization has no effect');
    }
  }

  /// Locale string
  /// 
  /// The locale js-file must be loaded
  /// More info: https://chmln.github.io/flatpickr/localization/
  /// 
  /// Default: `en`
  String get fpLocale => _options.locale;
  @Input()
  set fpLocale(String v) {
    _options.locale = v;
    if(_fp == null) {
      _initialConfig.locale = v;
    } else {
      _fp.set('locale', v);
    }
  }

  /// The maximum date that a user can pick to (inclusive).
  ///
  /// The value can be a [DateTime] object or a [String]
  /// 
  /// Default: `null`
  dynamic get fpMaxDate => _options.maxDate;
  @Input()
  set fpMaxDate(dynamic v) {
    _options.maxDate = v;
    var jsValue;
    if (v is DateTime) {
      jsValue = _dateTime2JsDate(v);
    } else if (v is String) {
      jsValue = v;
    } else {
      throw new ArgumentError('maxDate can be of type DateTime or String. ${v.runtimeType} given.');
    }
    if(_fp == null) {
      _initialConfig.maxDate = jsValue;
    } else {
      _fp.set('maxDate', jsValue);
    }
  }

  /// The minimum date that a user can start picking from (inclusive).
  ///
  /// The value can be a [DateTime] object or a [String]
  /// 
  /// Default: `null`
  dynamic get fpMinDate => _options.minDate;
  @Input()
  set fpMinDate(dynamic v) {
    _options.minDate = v;
    var jsValue;
    if (v is DateTime) {
      jsValue = _dateTime2JsDate(v);
    } else if (v is String) {
      jsValue = v;
    } else {
      throw new ArgumentError('minDate can be of type DateTime or String. ${v.runtimeType} given.');
    }
    if(_fp == null) {
      _initialConfig.minDate = jsValue;
    } else {
      _fp.set('minDate', jsValue);
    }
  }

  /// Adjusts the step for the minute input (incl. scrolling)
  ///
  /// Default: `5`
  int get fpMinuteIncrement => _options.minuteIncrement;
  @Input()
  set fpMinuteIncrement(int v) {
    _options.minuteIncrement = v;
    if(_fp == null) {
      _initialConfig.minuteIncrement = v;
    } else {
      window.console.warn('Changing the value of minuteIncrement after component initialization has no effect');
    }
  }

  /// "single", "multiple", or "range"
  ///
  /// Default: "single"
  String get fpMode => _options.mode;
  @Input()
  set fpMode(String v) {
    _options.mode = v;
    if(_fp == null) {
      _initialConfig.mode = v;
    } else {
      window.console.warn('It has no sense to change mode after component initialization');
    }
  }

  /// HTML for the arrow icon, used to switch months.
  ///
  /// Default: `>`
  String get fpNextArrow => _options.nextArrow;
  @Input()
  set fpNextArrow(String v) {
    _options.nextArrow = v;
    if(_fp == null) {
      _initialConfig.nextArrow = v;
    } else {
      window.console.warn('Changing the value of nextArrow after component initialization has no effect');
    }
  }

  /// Hides the day selection in calendar.
  /// 
  /// Use it along with enableTime to create a time picker.
  ///
  /// Default: `false`
  bool get fpNoCalendar => _options.noCalendar;
  @Input()
  set fpNoCalendar(bool v) {
    _options.noCalendar = v;
    if(_fp == null) {
      _initialConfig.noCalendar = v;
    } else {
      window.console.warn('Changing the value of noCalendar after component initialization has no effect');
    }
  }

  final _onChange = new StreamController<List<DateTime>>();
  
  /// Change selected dates events
  @Output()
  Stream<List<DateTime>> get fpOnChange => _onChange.stream;

  final _onClose = new StreamController<FlatPickr>();
  
  /// Close claendar events
  @Output()
  Stream<FlatPickr> get fpOnClose => _onClose.stream;

  final _onOpen = new StreamController<FlatPickr>();
  
  /// Open calendar events
  @Output()
  Stream<FlatPickr> get fpOnOpen => _onOpen.stream;

  final _onReady = new StreamController<FlatPickr>();
  
  /// Control ready event
  @Output()
  Stream<FlatPickr> get fpOnReady => _onReady.stream;

  /// HTML for the left arrow icon.
  ///
  /// Default: `<`
  String get fpPrevArrow => _options.prevArrow;
  @Input()
  set fpPrevArrow(String v) {
    _options.prevArrow = v;
    if(_fp == null) {
      _initialConfig.prevArrow = v;
    } else {
      window.console.warn('Changing the value of prevArrow after component initialization has no effect');
    }
  }

  /// Show the month using the shorthand version (ie, Sep instead of September).
  ///
  /// Default: `false`
  bool get fpShorthandCurrentMonth => _options.shorthandCurrentMonth;
  @Input()
  set fpShorthandCurrentMonth(bool v) {
    _options.shorthandCurrentMonth = v;
    if(_fp == null) {
      _initialConfig.shorthandCurrentMonth = v;
    } else {
      _fp.set('shorthandCurrentMonth', v);
    }
  }

  /// Position the calendar inside the wrapper and next to the input element.
  /// 
  /// Leave `false` unless you know what you're doing.
  ///
  /// Default: `false`
  bool get fpStatic => _options.static;
  @Input()
  set fpStatic(bool v) {
    _options.static = v;
    if(_fp == null) {
      _initialConfig.static = v;
    } else {
      window.console.warn('Changing the value of static after component initialization has no effect');
    }
  }

  /// Displays time picker in 24 hour mode without AM/PM selection when enabled.
  ///
  /// Default: `false`
  bool get fpTime24hr => _options.time_24hr;
  @Input()
  set fpTime24hr(bool v) {
    _options.time_24hr = v;
    if(_fp == null) {
      _initialConfig.time_24hr = v;
    } else {
      window.console.warn('Changing the value of time_24hr after component initialization has no effect');
    }
  }

  /// Enables display of week numbers in calendar.
  ///
  /// Default: `false`
  bool get fpWeekNumbers => _options.weekNumbers;
  @Input()
  set fpWeekNumbers(bool v) {
    _options.weekNumbers = v;
    if(_fp == null) {
      _initialConfig.weekNumbers = v;
    } else {
      window.console.warn('Changing the value of weekNumbers after component initialization has no effect');
    }
  }

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
  bool get fpWrap => _options.wrap;
  @Input()
  set fpWrap(bool v) {
    _options.wrap = v;
    if(_fp == null) {
      _initialConfig.wrap = v;
    } else {
      window.console.warn('Changing the value of wrap after component initialization has no effect');      
    }
  }

  /// JavaScript instance of flatpickr object
  FlatPickrJs _fp;
  
  /// The array of selected dates (DateTime objects).
  List<DateTime> get selectedDates {
    return _fp.selectedDates.map((JsObject dateObj) {
        return _jsDate2DateTime(dateObj);
    }).toList();
  }
  
  /// The year currently displayed on the calendar.
  int get currentYear => _fp.currentYear;

  /// The zero-indexed month number (0-11) currently displayed on the calendar.
  int get currentMonth => _fp.currentMonth;

  /// The configuration object (defaults + user-specified options).
  FpConfigJs get config => _fp.config;

  /// Changes the current month.
  /// 
  /// `monthNum` - integer offset or absolute value of month (0 - January)
  /// `isOffset` - defines if the first argument is offset or absolute value (Default: `true`)
  /// Examples:
  ///     @ViewChild(FlatPickr)
  ///     FlatPickr fp;
  ///     ...
  ///     fp.changeMonth(-1); // One month back
  ///     fp.changeMonth(2); // Two months forward
  ///     fp.changeMonth(1, false); // Set February
  void changeMonth(int monthNum, [bool isOffset = true]) => _fp.changeMonth(monthNum, isOffset);
  
  /// Closes the calendar.
  void close() => _fp.close();

  /// Returns a string representation of `date`,  formatted as per `formatStr`
  String formatDate(DateTime date, String formatStr) {
    return _fp.formatDate(_dateTime2JsDate(date), formatStr);
  }

  /// Sets the calendar view to the year and month of `date`.
  /// 
  /// `date` can be a date [String], a [DateTime], or nothing.
  /// If `date` is undefined, the view is set to the latest selected date, the minDate, or today’s date
  void jumpToDate([dynamic date]) {
    if(date is DateTime) {
      _fp.jumpToDate(_dateTime2JsDate(date));
    } else if(date is String || date == null) {
      _fp.jumpToDate(date);
    } else {
      throw(new ArgumentError('jumpToDate accepts only DateTime, String or null as its argument. ${date.runtimeType} given'));
    }
  }

  /// Shows/opens the calendar.
  void open() => _fp.open();

  /// Parses a date string or a timestamp, and returns a [DateTime]
  DateTime parseDate(String dateStr, [String dateFormat]) => DateTime.parse(_fp.formatDate(_fp.parseDate(dateStr, dateFormat), 'YmdTHiS'));

  /// Redraws the calendar. Shouldn’t be necessary in most cases.
  void redraw() => _fp.redraw();

  /// Sets the current selected date(s) to `date`
  /// 
  /// `date` can be a date [String], a [DateTime], or a [List<DateTime>].
  /// Optionally, pass true as the second argument to force any onChange events to fire.
  /// And if you’re passing a date string with a format other than your dateFormat, provide a dateStrFormat e.g. "m/d/Y".
  void setDate(dynamic date, [bool triggerChange = false, String dateStrFormat]) {
    if(date is DateTime) {
      _fp.setDate(_dateTime2JsDate(date), triggerChange);
    } else if(date is String) {
      _fp.setDate(date, triggerChange, dateStrFormat);
    } else if(date is List<DateTime>) {
      List<JsObject> jsDates = date.map((d) {
        return _dateTime2JsDate(d);
      }).toList();
      _fp.setDate(jsDates, triggerChange);
    } else {
      throw(new ArgumentError('setDate accepts only DateTime, String or List<DateTime> as its argument. ${date.runtimeType} given'));
    }
  }

  /// Shows/opens the calendar if its closed, hides/closes it otherwise.
  void toggle() => _fp.toggle();

  /// The text input element associated with flatpickr.
  HtmlElement get input => _fp.input;

  /// This is the div.flatpickr-calendar element.
  HtmlElement get calendarContainer => _fp.calendarContainer;

  /// The “left arrow” element responsible for decrementing the current month.
  HtmlElement get prevMonthNav => _fp.prevMonthNav;

  /// The “right arrow” element responsible for incrementing the current month.
  HtmlElement get nextMonthNav => _fp.nextMonthNav;

  /// The span holding the current month’s name.
  HtmlElement get currentMonthElement => _fp.currentMonthElement;

  /// The input holding the current year.
  HtmlElement get currentYearElement => _fp.currentYearElement;

  /// The container for all the day elements.
  HtmlElement get days => _fp.days;

  @override
  ngAfterViewInit() {
    _initialConfig.onChange = [allowInterop(
      (List jsSelectedDates, String dateStr, FlatPickrJs instance, e) {
        _onChange.add(selectedDates);
      }
    )];
    _initialConfig.onClose = [allowInterop(
      (List jsSelectedDates, String dateStr, FlatPickrJs instance, e) {
        _onClose.add(this);
      }
    )];
    _initialConfig.onOpen = [allowInterop(
      (List jsSelectedDates, String dateStr, FlatPickrJs instance, e) {
        _onOpen.add(this);
      }
    )];
    _initialConfig.onReady = [allowInterop(
      (List jsSelectedDates, String dateStr, FlatPickrJs instance, e) {
        _onReady.add(this);
      }
    )];
    _fp = flatpickr(_element, _initialConfig);
  }

  @override
  ngOnDestroy() {
    _fp.destroy();
  }

  /// Transforms Dart DateTime object to JS Date
  JsObject _dateTime2JsDate(DateTime date) {
    return FP.parseDate(date.toIso8601String(), 'Z');
  }

  /// Transforms JS Date to Dart DateTime object
  DateTime _jsDate2DateTime(JsObject dateObj) {
    return DateTime.parse(FP.formatDate(dateObj, 'Y-m-d H:i:S'));
  }
}
