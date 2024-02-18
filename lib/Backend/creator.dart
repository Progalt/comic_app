

enum CreatorRoles {
  unknown, 
  artist, 
  penciller,
  inker,
  colourist,
  letterer,
  writer, 
  editor,
  cover
}

String rolesToString(CreatorRoles role) {
  switch(role) {
    case CreatorRoles.artist: return "Artist";
    case CreatorRoles.penciller: return "Penciller";
    case CreatorRoles.inker: return "Inker";
    case CreatorRoles.colourist: return "Colorist";
    case CreatorRoles.letterer: return "Letterer";
    case CreatorRoles.writer: return "Writer";
    case CreatorRoles.editor: return "Editor";
    case CreatorRoles.cover: return "Cover";
    default: return "Unknown";
  }
}

class Creator {
  int id = 0; 
  String name = "";
}