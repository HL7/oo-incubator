{% sql {
  "query": "SELECT Name, Description, Web FROM Resources WHERE Type = 'StructureDefinition' AND kind = 'resource' AND derivation = 'specialization' ORDER BY Name",
  "columns": [
    { "source": "Name", "title": "Resource", "type": "link", "target": "Web" },
    { "source": "Description", "type": "markdown" }
  ]
} %}