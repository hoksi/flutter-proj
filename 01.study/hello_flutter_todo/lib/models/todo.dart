class Todo {
  String title; // 할 일 내용
  bool isCompleted; // 완료 여부

  Todo({
    required this.title,
    this.isCompleted = false, // 기본값은 미완료
  });

  // 선택 사항: Todo 객체의 내용을 문자열로 표현 (디버깅 용이)
  @override
  String toString() {
    return 'Todo(title: $title, isCompleted: $isCompleted)';
  }
}
