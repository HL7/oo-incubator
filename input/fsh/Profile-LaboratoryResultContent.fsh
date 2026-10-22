Profile: LaboratoryResultContent
Parent: Observation
Id: laboratory-result-content
Title: "Laboratory Result Content"
Description: "An individual laboratory result with a required value, patient, order, testing laboratory, and specimen. Data-absent-reason-only results and valueless organizers do not conform to this profile."

* ^url = "http://hl7.org/fhir/uv/oo-incubator/StructureDefinition/laboratory-result-content"
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

* . ^short = "Laboratory result with an actual value"
* basedOn 1..*
* basedOn only Reference(LaboratoryOrderContent)
* category 1..*
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains laboratory 1..1
* category[laboratory] = http://terminology.hl7.org/CodeSystem/observation-category#laboratory
* subject 1..1
* subject only Reference(Patient)
* subject ^comment = "The referenced Patient must provide the patient name and an identification number."
* performer 1..*
* performer only Reference(Organization or Practitioner or PractitionerRole)
* performer ^slicing.discriminator.type = #type
* performer ^slicing.discriminator.path = "resolve()"
* performer ^slicing.rules = #open
* performer contains testingLaboratory 1..*
* performer[testingLaboratory] only Reference(Organization)
* performer[testingLaboratory] ^short = "Laboratory that actually performed this test"
* performer[testingLaboratory] ^comment = "Each referenced testing laboratory, including a referral laboratory, must provide its name and physical address in Organization.name and Organization.contact.address. Include its CLIA identifier when applicable. Organization is not profiled by this OO profile."
* specimen 1..1
* specimen only Reference(LaboratorySpecimenContent)
* value[x] 1..1
* value[x] ^short = "Actual laboratory result; a value is required"
* value[x] ^comment = "A data absent reason cannot substitute for the result in this report-content profile. Numeric and nonnumeric result types remain available. Use a separate Observation for each result; a valueless panel organizer does not conform."
* dataAbsentReason 0..0
* valueQuantity.value 1..1
* valueQuantity.unit 1..1
* valueQuantity.system 1..1
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code 1..1
* valueQuantity ^comment = "Quantitative results must include a numeric value and UCUM units; use the UCUM code 1 for dimensionless quantities where appropriate."
* referenceRange MS
* referenceRange ^comment = "Provide the performing laboratory's applicable reference interval or reference text. Omit it only when a reference interval is not applicable to the test and patient."
* note MS
* note ^comment = "Include the effect of any specimen condition that limits adequacy or interpretation of this result. For a corrected result, also describe the correction and its reason."
* component.value[x] 1..1
* component.dataAbsentReason 0..0
* component.valueQuantity.value 1..1
* component.valueQuantity.unit 1..1
* component.valueQuantity.system 1..1
* component.valueQuantity.system = "http://unitsofmeasure.org"
* component.valueQuantity.code 1..1
* component.referenceRange MS

// LRI-informed content decisions; see docs/laboratory-report-lri-gap-analysis.md.
* identifier 1..*
* identifier.system 1..1
* identifier.value 1..1
* identifier ^comment = "Identify the individual result independently of its report or order so that repeated tests and corrected versions can be reconciled. Preserve this identity across versions of the same result."
* code.coding 1..*
* code.coding.system 1..1
* code.coding.code 1..1
* code.text MS
* code ^comment = "Supply the test identifier as a system/code pair. Include LOINC when an appropriate mapping is available, preserving the original local code and text as additional codings and text. This profile does not assert the complete LRI terminology requirements."
* effective[x] 1..1
* effectivePeriod.start 1..1
* effective[x] ^comment = "The clinically relevant observation date/time or period, generally specimen collection for a specimen-based test. Do not substitute result release time or instrument analysis time."
* issued MS
* interpretation MS
* method MS
* interpretation ^comment = "Preserve applicable abnormal, critical, or other interpretation flags supplied with the result; do not infer that a value within a numeric reference interval has no other interpretive significance."
* component.code.coding 1..*
* component.code.coding.system 1..1
* component.code.coding.code 1..1
* component.code.text MS
* component.interpretation MS
* obeys lab-result-correction-note

Invariant: lab-result-correction-note
Description: "A corrected result must include a note explaining the correction."
Severity: #error
Expression: "status = 'corrected' implies note.text.exists()"
