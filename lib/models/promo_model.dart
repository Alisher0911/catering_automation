import 'package:equatable/equatable.dart';

class Promo extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  Promo({ required this.id, required this.title, required this.description, required this.imageUrl});

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    imageUrl
  ];
  
  static List<Promo> promos = [
    Promo(
      id: 1,
      title: "Бесплатная доставка при первых 3 заказах",
      description: "Бесплатная доставка при заказе свыше 2000 тенге",
      imageUrl: "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max"
    ),
    Promo(
      id: 1,
      title: "Скидка 20% на некоторые рестораны",
      description: "Получите скидку в более чем 20 ресторанах",
      imageUrl: "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60"
    ),
  ];
}