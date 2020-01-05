import 'package:flutter/material.dart';

class EventDates extends StatefulWidget {
  final Function onStartDateChange;
  final Function onEndDateChange;

  EventDates({
    this.onStartDateChange,
    this.onEndDateChange,
  });

  @override
  State<StatefulWidget> createState() {
    return _EventDatesState();
  }
}

class _EventDatesState extends State<EventDates> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate;

  bool _enableEndDate = false;

  void toggleEndDate(bool enabled) {
    setState(() {
      _enableEndDate = enabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          DatePickerWidget(
            label: 'Start Date',
            onChange: widget.onStartDateChange,
            value: _startDate,
          ),
          _enableEndDate
              ? Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      DatePickerWidget(
                        label: 'End Date',
                        value: _endDate,
                        onChange: widget.onEndDateChange,
                      ),
                      MaterialButton(
                        child: const Text('Remove x'),
                        onPressed: () => toggleEndDate(false),
                      ),
                    ],
                  ),
                )
              : MaterialButton(
                  child: const Text('End time +'),
                  onPressed: () => toggleEndDate(true),
                ),
        ],
      ),
    );
  }
}

class DatePickerWidget extends StatelessWidget {
  final String label;
  final DateTime value;
  final Function onChange;

  DatePickerWidget({
    Key key,
    this.label,
    this.value,
    this.onChange,
  }) : super(key: key);

  Future selectEventDate(BuildContext context, Function callback) async {
    DateTime eventTime = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now().add(Duration(hours: 1)),
      lastDate: DateTime.now().add(
        Duration(days: 365 * 2),
      ),
    );

    if (eventTime == null) {
      return false;
    }

    return false;
    // return callback(eventTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        // Avoid exception when keyboard focuses date-time input
        // @see https://github.com/flutter/flutter/issues/18672
        child: GestureDetector(
          onTap: () => selectEventDate(context, onChange),
          child: AbsorbPointer(
            child: TextField(
              controller: TextEditingController(
                text: value.toString(),
              ),
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
