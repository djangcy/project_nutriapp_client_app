class RecipeQueryBody {
  const RecipeQueryBody(this.text);

  final String text;

  Map<String, dynamic> toJson() => {
        'text': text,
      };
}
