{% sql {
  "query": "SELECT Name, Description, Web FROM Resources WHERE Type = 'StructureDefinition' AND sdType = 'Extension' AND derivation = 'constraint' ORDER BY Name",
  "columns": [
    { "source": "Name", "title": "Extension", "type": "link", "target": "Web" },
    { "source": "Description", "type": "markdown" }
  ]
} %}