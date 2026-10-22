Profile: LaboratoryOrderContent
Parent: ServiceRequest
Id: laboratory-order-content
Title: "Laboratory Order Content"
Description: "A laboratory test order identifying the requested test, patient, and ordering physician or other legally authorized ordering practitioner."

* ^url = "http://hl7.org/fhir/uv/oo-incubator/StructureDefinition/laboratory-order-content"
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

* . ^short = "Laboratory order report content"
* intent = #order
* code 1..1
* code.concept 1..1
* subject only Reference(Patient)
* subject ^comment = "The referenced Patient must provide the patient name and an identification number."
* requester 1..1
* requester only Reference(Practitioner or PractitionerRole)
* requester ^short = "Ordering physician or other legally authorized practitioner"
* requester ^comment = "The ordering practitioner's name must be available to the clinician. A PractitionerRole reference must identify its Practitioner. Authorization and the order audit trail are implementation responsibilities."

// LRI-informed content decisions; see docs/laboratory-report-lri-gap-analysis.md.
* identifier 1..*
* identifier.system 1..1
* identifier.value 1..1
* identifier.type MS
* identifier ^comment = "Preserve placer and filler order identifiers, with their assigning namespaces and types, when supplied. These are order identifiers, not the DiagnosticReport's business identifier."
* code.concept.coding 1..*
* code.concept.coding.system 1..1
* code.concept.coding.code 1..1
* code.concept.text MS
* requisition MS
* authoredOn MS
* statusReason MS
* note MS
* statusReason ^comment = "Preserve reasons for an order's cancellation or other status when supplied. An order or specimen problem does not justify fabricating an Observation value to satisfy the result profile."
