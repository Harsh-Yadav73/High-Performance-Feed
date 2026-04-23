import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: 'https://uelrwpzfvulridcbzich.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVlbHJ3cHpmdnVscmlkY2J6aWNoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY4NzE1NzAsImV4cCI6MjA5MjQ0NzU3MH0.pE93ZATTq0uW8C4i8hEmQHGG-zGLoNsCRzeXiHwbo-0',
  );
}

final supabase = Supabase.instance.client;