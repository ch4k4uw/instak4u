import 'package:presenter/common.dart';

class EventDetailsViewFixture {
  const EventDetailsViewFixture._();

  static const eventDetails = EventDetailsView(
    id: "xxx",
    title: "Feira de adoção de animais na Redenção",
    description: """
        O Patas Dadas estará na Redenção, nesse domingo, com cães para adoção e produtos à venda!
        
        Na ocasião, teremos bottons, bloquinhos e camisetas!
        
        Traga seu Pet, os amigos e o chima, e venha aproveitar esse dia de sol com a gente e com alguns de nossos peludinhos - que estarão prontinhos para ganhar o ♥ de um humano bem legal pra chamar de seu. 
        
        Aceitaremos todos os tipos de doação:
        - guias e coleiras em bom estado
        - ração (as que mais precisamos no momento são sênior e filhote)
        - roupinhas 
        - cobertas 
        - remédios dentro do prazo de validade
        """,
    image: "https://cdn.pixabay.com/photo/2015/01/08/18/30/entrepreneur-59337"
        "8_960_720.jpg",
    latitude: -23.5558,
    longitude: -46.6396,
  );
}
