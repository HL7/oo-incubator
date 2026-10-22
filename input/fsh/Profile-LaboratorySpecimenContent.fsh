Profile: LaboratorySpecimenContent
Parent: Specimen
Id: laboratory-specimen-content
Title: "Laboratory Specimen Content"
Description: "A laboratory specimen with its source or type, patient, associated order, collection date, and support for specimen conditions that may limit testing adequacy."

* ^url = "http://hl7.org/fhir/uv/oo-incubator/StructureDefinition/laboratory-specimen-content"
* ^version = "0.1.0-snapshot"
* ^status = #active
* ^experimental = false
* ^date = "2026-10-22T00:00:00+00:00"
* ^publisher = "HL7 International / Orders and Observations"
* ^contact.telecom.system = #url
* ^contact.telecom.value = "http://www.hl7.org/Special/committees/orders/"
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm].valueInteger = 1
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-wg].valueCode = #oo
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #trial-use

* . ^short = "Laboratory specimen report content"
* type 1..1
* type ^short = "Specimen source or type"
* subject 1..1
* subject only Reference(Patient)
* request 1..*
* request only Reference(LaboratoryOrderContent)
* collection 1..1
* collection.collected[x] 1..1
* collection.collected[x] ^comment = "Provide the collection date and, when appropriate to the test, the time and time zone. A collection period must identify at least its start date."
* collection.collectedPeriod.start 1..1
* condition MS
* condition ^comment = "Record any specimen condition that may limit the adequacy of testing, such as hemolysis. Absence of a limitation does not require an artificial condition entry."
* note MS
* note ^comment = "Describe the testing limitation when it cannot be adequately expressed by Specimen.condition alone. Its effect on a specific result is also recorded in Observation.note."

// LRI-informed content decisions; see docs/laboratory-report-lri-gap-analysis.md.
* identifier 1..*
* identifier.system 1..1
* identifier.value 1..1
* identifier ^comment = "Preserve the specimen's business identifier with its assigning namespace. Carry both placer and filler specimen identifiers when supplied; do not substitute the order identifier."
* type.coding 1..*
* type.coding.system 1..1
* type.coding.code 1..1
* type.text MS
* status MS
* receivedTime MS
* collection.method MS
* collection.bodyStructure MS
* collection.bodyStructure ^comment = "Preserve the anatomic source site when applicable. In R6 this is a CodeableReference to a BodyStructure or a concept; specimen type alone does not identify an anatomic site."
* status ^comment = "Preserve specimen availability or unsatisfactory status when known. Do not infer test rejection solely from a specimen condition; suitability depends on the particular requested test."
