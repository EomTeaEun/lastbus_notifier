import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'CustomScheduleInputPage.dart';
import 'menuPage.dart';
import 'personal_info_page.dart';
import 'FavoriteRoutesPage.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final Map<DateTime, List<String>> _schedules = {};

  late final DateTime _firstDay;
  late final DateTime _lastDay;
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  List<String> get _selectedDaySchedules => _schedules[_selectedDay] ?? [];

  @override
  void initState() {
    super.initState();
    _firstDay = DateTime.utc(2010, 10, 16);
    _lastDay = DateTime.utc(2030, 3, 14);
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  void _navigateAndAddSchedule() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CustomScheduleInputPage(),
      ),
    );

    if (result is String && result.isNotEmpty && _selectedDay != null) {
      setState(() {
        final dateKey = DateTime.utc(
            _selectedDay!.year, _selectedDay!.month, _selectedDay!.day);
        _schedules.putIfAbsent(dateKey, () => []).add(result);
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    final key = DateTime.utc(day.year, day.month, day.day);
    return _schedules[key]?.map((s) => Event(s)).toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('일정 확인'),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuPage()),
                );
              },
              tooltip: '메뉴',
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _navigateAndAddSchedule,
              tooltip: '일정 추가',
            )
          ],
        ),
        body: Column(
          children: [
            TableCalendar<Event>(
              firstDay: _firstDay,
              lastDay: _lastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarFormat: CalendarFormat.month,
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
              },
              onFormatChanged: (_) {},
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: _getEventsForDay,
              calendarStyle: const CalendarStyle(
                markerDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${_selectedDay?.month}월 ${_selectedDay?.day}일 일정',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _selectedDaySchedules.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.event_note, color: Colors.black),
                    title: Text(
                      _selectedDaySchedules[index],
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
            )
          ],
        ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PersonalInfoPage(),
          ),
        );
        },
      backgroundColor: Colors.blueAccent,
      child: const Icon(Icons.person),
    ),
      ),
    );
  }
}

class Event {
  final String title;
  Event(this.title);

  @override
  String toString() => title;
}
