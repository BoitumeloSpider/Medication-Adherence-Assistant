import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class MedicationRemindersScreen extends StatefulWidget {
  const MedicationRemindersScreen({super.key});

  @override
  State<MedicationRemindersScreen> createState() => _MedicationRemindersScreenState();
}

class _MedicationRemindersScreenState extends State<MedicationRemindersScreen> {
  List<Map<String, dynamic>> _reminders = [];

  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _selectedFrequency = 'Once';
  bool _isClinicVisit = false;

  int _notificationIdCounter = 0;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'medication_channel',
          channelName: 'Medication Reminders',
          channelDescription: 'Reminders for medications and clinic visits',
          defaultColor: const Color(0xFF1F6F68),
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
    );
  }

  void _scheduleNotification(Map<String, dynamic> reminder) {
    final dateTime = reminder["dateTime"] as DateTime;

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: reminder["id"] as int,
        channelKey: 'medication_channel',
        title: 'Reminder: ${reminder["name"]}',
        body: reminder["isClinicVisit"]
            ? 'Time for your clinic visit'
            : 'Time to take your medication',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        year: dateTime.year,
        month: dateTime.month,
        day: dateTime.day,
        hour: dateTime.hour,
        minute: dateTime.minute,
        second: 0,
        repeats: reminder["frequency"] != 'Once',
      ),
    );
  }

  void _addReminderDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: const Text("Add Reminder"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: "Medication / Visit Name"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _notesController,
                  decoration:
                  const InputDecoration(labelText: "Notes / Instructions"),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("Clinic Visit"),
                    Checkbox(
                      value: _isClinicVisit,
                      onChanged: (value) {
                        setStateDialog(() {
                          _isClinicVisit = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setStateDialog(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(_selectedDate == null
                      ? "Pick Date"
                      : "Date: ${DateFormat.yMMMd().format(_selectedDate!)}"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setStateDialog(() {
                        _selectedTime = pickedTime;
                      });
                    }
                  },
                  child: Text(_selectedTime == null
                      ? "Pick Time"
                      : "Time: ${_selectedTime!.format(context)}"),
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: _selectedFrequency,
                  onChanged: (value) {
                    setStateDialog(() {
                      _selectedFrequency = value!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(value: 'Once', child: Text('Once')),
                    DropdownMenuItem(value: 'Daily', child: Text('Daily')),
                    DropdownMenuItem(value: 'Weekly', child: Text('Weekly')),
                    DropdownMenuItem(value: 'Monthly', child: Text('Monthly')),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _clearInputs();
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isEmpty ||
                    _selectedDate == null ||
                    _selectedTime == null) return;

                final reminderDateTime = DateTime(
                  _selectedDate!.year,
                  _selectedDate!.month,
                  _selectedDate!.day,
                  _selectedTime!.hour,
                  _selectedTime!.minute,
                );

                final reminder = {
                  "id": _notificationIdCounter,
                  "name": _nameController.text,
                  "notes": _notesController.text,
                  "dateTime": reminderDateTime,
                  "frequency": _selectedFrequency,
                  "isClinicVisit": _isClinicVisit,
                  "completed": false,
                  "taken": false, // ✅ Medication taken
                };

                setState(() {
                  _reminders.add(reminder);
                  _notificationIdCounter++;
                });

                _scheduleNotification(reminder);
                _clearInputs();
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }

  void _clearInputs() {
    _nameController.clear();
    _notesController.clear();
    _selectedDate = null;
    _selectedTime = null;
    _selectedFrequency = 'Once';
    _isClinicVisit = false;
  }

  @override
  Widget build(BuildContext context) {
    final activeReminders = _reminders.where((r) => !r["completed"]).toList();
    final pastReminders = _reminders.where((r) => r["completed"]).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Medication Reminders"),
        backgroundColor: const Color(0xFF1F6F68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Text("Active Reminders",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  if (activeReminders.isEmpty)
                    const Text("No active reminders."),
                  ...activeReminders.map(
                        (r) => Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      color: r["isClinicVisit"]
                          ? Colors.purple.shade50
                          : Colors.green.shade50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(r["name"],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text(
                                      "${r["notes"]}\nDate: ${DateFormat.yMMMd().format(r["dateTime"])}\nTime: ${DateFormat.jm().format(r["dateTime"])}\nFrequency: ${r["frequency"]}",
                                      style: const TextStyle(fontSize: 13)),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                if (!r["taken"] && !r["isClinicVisit"])
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green.shade600,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20))),
                                    child: const Text("Mark Taken"),
                                    onPressed: () {
                                      setState(() {
                                        r["taken"] = true;
                                      });
                                    },
                                  ),
                                if (r["taken"] || r["isClinicVisit"])
                                  IconButton(
                                    icon: const Icon(Icons.check_circle,
                                        color: Colors.green, size: 30),
                                    onPressed: () {
                                      setState(() {
                                        r["completed"] = true;
                                      });
                                    },
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Past Reminders",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  if (pastReminders.isEmpty) const Text("No past reminders."),
                  ...pastReminders.map(
                        (r) => Card(
                      color: r["isClinicVisit"]
                          ? Colors.purple.shade100
                          : Colors.grey.shade200,
                      child: ListTile(
                        title: Text(r["name"]),
                        subtitle: Text(
                            "${r["notes"]}\nDate: ${DateFormat.yMMMd().format(r["dateTime"])}\nTime: ${DateFormat.jm().format(r["dateTime"])}\nFrequency: ${r["frequency"]}"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addReminderDialog,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F6F68),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: const Text("Add New Reminder",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}