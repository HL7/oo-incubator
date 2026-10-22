### Laboratory Report Profiles

The laboratory report content profiles constrain the OO-owned DiagnosticReport, Observation, Specimen, and ServiceRequest resources used in the [CLIA laboratory report example](Bundle-clia-report.html). They cover individual results with actual values, their report, specimen, and order context. Quantitative results require a numeric value and UCUM units; nonnumeric result types remain available. Panel organizers without their own values do not conform to the Laboratory Result Content profile.

For these profiles, Must Support means that producing systems must be able to record and supply the marked information when applicable, and receiving systems must be able to retain it and make it available to the clinician. Reference intervals and specimen limitations are conditional on the test and specimen; Must Support does not require fabricated information when it is not applicable.

The profiles require business identifiers on reports, results, orders, and specimens, together with coded test and specimen identity. Results require a clinically relevant date/time or period. Testing laboratory attribution is mandatory; additional observer roles are permitted. Corrected reports and results must include a note explaining the correction. Interpretation flags, methods, specimen receipt and anatomic source, and report relationships are supported when applicable.

These constraints incorporate lessons from accessible HL7 mapping guidance and historical Laboratory Results Interface (LRI) test scenarios. They do not assert equivalence to the complete LRI Edition 5 requirements. Instrument analysis time, rejected-test reporting, panel organizers, and full correction and delivery workflows need further design.

Patient, Practitioner, PractitionerRole, Organization, and Bundle remain unprofiled. Requirements for patient names and identifiers, ordering practitioner names, and laboratory names and physical addresses are documented on the references; local validation of the four profiles alone does not enforce the contents of those unprofiled resources. See the example's requirement mapping for the supporting content and presentation expectations. These profiles describe report content and do not establish regulatory or accreditation compliance.

{% sql {
  "query": "SELECT Name, Description, Web FROM Resources WHERE Type = 'StructureDefinition' AND kind = 'resource' AND derivation = 'constraint' AND Name LIKE 'Laboratory%' ORDER BY Name",
  "columns": [
    { "source": "Name", "title": "Profile", "type": "link", "target": "Web" },
    { "source": "Description", "type": "markdown" }
  ]
} %}

### Other Profiles

{% sql {
  "query": "SELECT Name, Description, Web FROM Resources WHERE Type = 'StructureDefinition' AND kind = 'resource' AND derivation = 'constraint' AND Name NOT LIKE 'Laboratory%' ORDER BY Name",
  "columns": [
    { "source": "Name", "title": "Profile", "type": "link", "target": "Web" },
    { "source": "Description", "type": "markdown" }
  ]
} %}
