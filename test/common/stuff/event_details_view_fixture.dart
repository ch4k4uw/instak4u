import 'package:presenter/common/interaction/event_details_view.dart';

class EventDetailsViewFixture {
  static const encodedEventDetails = "o3h4eNkqRmVpcmEgZGUgYWRvw6fDo28gZGUgYW5pb"
      "WFpcyBuYSBSZWRlbsOnw6Nv2gKdICAgICAgICBPIFBhdGFzIERhZGFzIGVzdGFyw6EgbmEgU"
      "mVkZW7Dp8OjbywgbmVzc2UgZG9taW5nbywgY29tIGPDo2VzIHBhcmEgYWRvw6fDo28gZSBwc"
      "m9kdXRvcyDDoCB2ZW5kYSEKICAgICAgICAKICAgICAgICBOYSBvY2FzacOjbywgdGVyZW1vc"
      "yBib3R0b25zLCBibG9xdWluaG9zIGUgY2FtaXNldGFzIQogICAgICAgIAogICAgICAgIFRyY"
      "WdhIHNldSBQZXQsIG9zIGFtaWdvcyBlIG8gY2hpbWEsIGUgdmVuaGEgYXByb3ZlaXRhciBlc"
      "3NlIGRpYSBkZSBzb2wgY29tIGEgZ2VudGUgZSBjb20gYWxndW5zIGRlIG5vc3NvcyBwZWx1Z"
      "GluaG9zIC0gcXVlIGVzdGFyw6NvIHByb250aW5ob3MgcGFyYSBnYW5oYXIgbyDimaUgZGUgd"
      "W0gaHVtYW5vIGJlbSBsZWdhbCBwcmEgY2hhbWFyIGRlIHNldS4gCiAgICAgICAgCiAgICAgI"
      "CAgQWNlaXRhcmVtb3MgdG9kb3Mgb3MgdGlwb3MgZGUgZG9hw6fDo286CiAgICAgICAgLSBnd"
      "WlhcyBlIGNvbGVpcmFzIGVtIGJvbSBlc3RhZG8KICAgICAgICAtIHJhw6fDo28gKGFzIHF1Z"
      "SBtYWlzIHByZWNpc2Ftb3Mgbm8gbW9tZW50byBzw6NvIHPDqm5pb3IgZSBmaWxob3RlKQogI"
      "CAgICAgIC0gcm91cGluaGFzIAogICAgICAgIC0gY29iZXJ0YXMgCiAgICAgICAgLSByZW3Dq"
      "WRpb3MgZGVudHJvIGRvIHByYXpvIGRlIHZhbGlkYWRlCiAgICAgICAgywAAAAAAAAAAANlOa"
      "HR0cHM6Ly9jZG4ucGl4YWJheS5jb20vcGhvdG8vMjAxNS8wMS8wOC8xOC8zMC9lbnRyZXByZ"
      "W5ldXItNTkzMzc4Xzk2MF83MjAuanBny8A3jkjopx3ny8BHUd5prULE";
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