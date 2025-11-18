import 'package:flutter/material.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoteListPage(),
    );
  }
}

class NoteListPage extends StatefulWidget {
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  List<String> _notes1 = [];
  TextEditingController _noteController1 = TextEditingController();
  List<String> _notes2 = [];
  TextEditingController _noteController2 = TextEditingController();
  List<String> _notes3 = [];
  TextEditingController _noteController3 = TextEditingController();

  String _selectedCurrency = '₽';
  String _selectedPeriod = 'Ежемесячно';
  String _selectedCategory = 'Образование';
  
  List<String> _currencies = [];
  List<String> _currenciesTwo = [];
  List<String> _periods = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notes1 = prefs.getStringList('notes') ?? [];
      _notes2 = prefs.getStringList('notes2') ?? [];
      _notes3 = prefs.getStringList('notes3') ?? [];
      _currencies = prefs.getStringList('currencies') ?? [];
      _currenciesTwo = prefs.getStringList('currenciesTwo') ?? [];
      _periods = prefs.getStringList('periods') ?? [];
    });
  }

  Future<void> _saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notes', _notes1);
    await prefs.setStringList('notes2', _notes2);
    await prefs.setStringList('notes3', _notes3);
    await prefs.setStringList('currencies', _currencies);
    await prefs.setStringList('currenciesTwo', _currenciesTwo);
    await prefs.setStringList('periods', _periods);
  }

  void _addNote() {
    String text = _noteController1.text.trim();
    String text2 = _noteController2.text.trim();
    String text3 = _noteController3.text.trim();

    if (text.isNotEmpty) {
      setState(() {
        _notes1.add(text);
        _notes2.add(text2);
        _notes3.add(text3);
        _currencies.add(_selectedCurrency);
        _currenciesTwo.add(_selectedCategory);
        _periods.add(_selectedPeriod);

        _noteController1.clear();
        _noteController2.clear();
        _noteController3.clear();
      });
      _saveNotes();
    }
  }

  void _deleteNote(int index) {
    setState(() {
      _notes1.removeAt(index);
      _notes2.removeAt(index);
      _notes3.removeAt(index);
      _currencies.removeAt(index);
      _currenciesTwo.removeAt(index);
      _periods.removeAt(index);
    });
    _saveNotes();
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Container(
      width: 220,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Row(
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 1000,
                        height: 700,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.blue[700],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Менеджер подписок',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(

                                  children: [
                                    Row(
                                      children: [

                                        SizedBox(
                                          width: 300,
                                          height: 50,
                                          child: _buildTextField(_noteController1, 'Название Подписки'),
                                        ),

                                        SizedBox(width: 10),

                                        SizedBox(
                                          width: 300,
                                          height: 50,
                                          child: _buildTextField(_noteController2, 'Стоимость'),
                                        ),

                                      ],
                                    ),

                                    SizedBox(height: 20),

                                    Text(
                                      'Валюты:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                      ),
                                    ),

                                    SizedBox(height: 10),

                                    Row(
                                      children: [

                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() => _selectedCurrency = '\$');
                                          },
                                          child: Text('\$'),
                                        ),

                                        SizedBox(width: 10),

                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() => _selectedCurrency = '₽');
                                          },
                                          child: Text('₽'),
                                        ),

                                        SizedBox(width: 10),

                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() => _selectedCurrency = '€');
                                          },
                                          child: Text('€'),
                                        ),

                                      ],
                                    ),

                                    SizedBox(height: 20),

                                    Text(
                                      'Период оплаты:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                      ),
                                    ),

                                    SizedBox(height: 10),

                                    Row(
                                      children: [

                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() => _selectedPeriod = 'Еженедельно');
                                          },
                                          child: Text('Еженедельно'),
                                        ),

                                        SizedBox(width: 10),

                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() => _selectedPeriod = 'Ежемесячно');
                                          },
                                          child: Text('Ежемесячно'),
                                        ),

                                        SizedBox(width: 10),

                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() => _selectedPeriod = 'Ежегодно');
                                          },
                                          child: Text('Ежегодно'),
                                        ),

                                      ],
                                    ),

                                    SizedBox(height: 20),

                                    Text(
                                      'Категория:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                      ),
                                    ),

                                    SizedBox(height: 10),

                                    Row(
                                      children: [

                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() => _selectedCategory = 'Образование');
                                          },
                                          child: Text('Образование'),
                                        ),

                                        SizedBox(width: 10),

                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() => _selectedCategory = 'Новости');
                                          },
                                          child: Text('Новости'),
                                        ),

                                        SizedBox(width: 10),

                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() => _selectedCategory = 'Развлечения');
                                          },
                                          child: Text('Развлечения'),
                                        ),

                                      ],
                                    ),

                                    SizedBox(height: 10),

                                    Row(
                                      children: [

                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() => _selectedCategory = 'Фитнес');
                                          },
                                          child: Text('Фитнес'),
                                        ),

                                        SizedBox(width: 10),

                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() => _selectedCategory = 'Софт');
                                          },
                                          child: Text('Софт'),
                                        ),

                                      ],
                                    ),

                                    SizedBox(height: 20),

                                    Column(
                                      children: [

                                        SizedBox(
                                          width: 300,
                                          height: 50,
                                          child: _buildTextField(_noteController3, 'Дата следующего платежа'),
                                        ),

                                        SizedBox(height: 5),

                                        Padding(
                                          padding: EdgeInsets.all(1),
                                          child: ElevatedButton(
                                            onPressed: _addNote,
                                            child: Text('Добавить подписку'),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Divider(color: Colors.blue[700], thickness: 3),

                            Expanded(
                              child: _notes1.isEmpty
                                  ? Center(child: Text('Подписок пока нет'))
                                  : ListView.builder(
                                      itemCount: _notes1.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                Column( 
                                                  crossAxisAlignment: CrossAxisAlignment.start, 
                                                  children: [ 

                                                    Container(
                                                      height: 35,
                                                      padding: EdgeInsets.all(8),
                                                      child: Row(
                                                        children: [
                                                          Text(_notes1[index],
                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                      height: 35,
                                                      padding: EdgeInsets.all(8),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            _currenciesTwo[index],
                                                            style: TextStyle(fontSize: 11),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                      child: 
                                                      
                                                          Row( 
                                                            children: [
                                                              
                                                              Text( 
                                                                'Стоимость: ', 
                                                                style: TextStyle(fontSize: 12, color: Colors.black), 
                                                              ),

                                                            ], 
                                                          ),

                                                    ),

                                                    Container(
                                                      child: 
                                                      
                                                          Row( 
                                                            children: [ 

                                                              Text( 
                                                                'Период: ', 
                                                                style: TextStyle(fontSize: 12, color: Colors.black), 
                                                              ),

                                                            ], 
                                                          ),
                                                          
                                                    ),                                                  
                                                    Container(
                                                      child: 
                                                      
                                                          Row( 
                                                            children: [ 

                                                              Text( 
                                                                'Следующий платеж: ', 
                                                                style: TextStyle(fontSize: 12, color: Colors.black), 
                                                              ),
                                                              
                                                            ], 
                                                          ),
                                                    ), 
                                                  ],
                                                ),

                                                Spacer(),

                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end, 
                                                  children: [
                                                    Row(
                                                      children: [

                                                    Container( 
                                                      padding: EdgeInsets.symmetric(horizontal: 8), 
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [

                                                    Container(
                                                      padding: EdgeInsets.all(7),
                                                      child: IconButton(
                                                        onPressed: () => _deleteNote(index),
                                                        icon: Icon(Icons.clear_rounded, size: 20),
                                                      ),
                                                    ),

                                                       SizedBox(height: 15),


                                                          Container(
                                                            child: Row( 
                                                              children: [
                                                                
                                                              Text(
                                                                _notes2[index] + " " + _currencies[index],
                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                              ),

                                                            ],

                                                            ),
                                                          ),
                                                          
                                                          Container(
                                                            child: Row( 
                                                              children: [
                                                                
                                                              Text(
                                                                _periods[index],
                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                              ),
                                                            ],

                                                            ),
                                                          ),

                                                          Container(
                                                            child: Row( 
                                                              children: [
                                                                
                                                              Text(
                                                                _notes3[index],
                                                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                              ),
                                                            ],

                                                            ),
                                                          ),



                                                        ],
                                                      ),
                                                    ),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                            ),

                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}