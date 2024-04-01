class Habit {
  Habit(this.name);
  
  final String name;
  bool isCompleted = false;

  void setIsCompleted(isCompleted) {
    this.isCompleted = isCompleted;
  }
}