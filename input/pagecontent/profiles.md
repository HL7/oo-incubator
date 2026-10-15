{% sql {
  "query": "SELECT Name, Description, Web FROM Resources WHERE Type = 'StructureDefinition' AND kind = 'resource' AND derivation = 'constraint' ORDER BY Name",
  "columns": [
    { "source": "Name", "title": "Profile", "type": "link", "target": "Web" },
    { "source": "Description", "type": "markdown" }
  ]
} %}