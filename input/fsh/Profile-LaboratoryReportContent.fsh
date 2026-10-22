Profile: LaboratoryReportContent
Parent: DiagnosticReport
Id: laboratory-report-content
Title: "Laboratory Report Content"
Description: "A laboratory report containing patient, order, release date and time, reporting laboratory, specimen, and result references. This profile supports the CLIA and CAP report-content mapping described in the laboratory report example."

* ^url = "http://hl7.org/fhir/uv/oo-incubator/StructureDefinition/laboratory-report-content"
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

* . ^short = "Laboratory report content"
* basedOn 1..*
* basedOn only Reference(LaboratoryOrderContent)
* subject 1..1
* subject only Reference(Patient)
* subject ^comment = "The referenced Patient must provide the patient name and an identification number. Patient is not profiled by this OO profile."
* issued 1..1
* issued obeys lab-report-release-time
* issued ^short = "Report release date and time, including time zone"
* performer 1..*
* performer only Reference(Organization)
* performer ^comment = "Identify the laboratory responsible for issuing the report. Its Organization must provide a name and physical address. The actual testing laboratory is identified by each result's Observation.performer; referral laboratory details must remain available to the clinician."
* specimen 1..*
* specimen only Reference(LaboratorySpecimenContent)
* result 1..*
* result only Reference(LaboratoryResultContent)


// LRI-informed content decisions; see docs/laboratory-report-lri-gap-analysis.md.
* identifier 1..*
* identifier.system 1..1
* identifier.value 1..1
* identifier ^comment = "A stable report identifier supports reconciliation and correction. Preserve the report identity across corrected versions; resource id and meta.versionId do not replace the business identifier. Placer and filler order identifiers belong on the referenced ServiceRequest."
* code.coding 1..*
* code.coding.system 1..1
* code.coding.code 1..1
* code.text MS
* code ^comment = "Identify the reported test or panel using a coded identifier. Preserve supplied local codes and text alongside an available standard code; do not discard the source coding during translation."
* effective[x] MS
* effectivePeriod.start 1..1
* resultsInterpreter MS
* note MS
* relatesTo MS
* note ^comment = "Preserve report comments. For a corrected report, describe the correction and its reason; communicate and retain the prior version through the implementation's correction workflow."
* relatesTo ^comment = "Preserve an explicit relationship to a prior report when the correction is represented as a distinct report. A version update of the same report is not a new report identifier."
* obeys lab-report-correction-note

Invariant: lab-report-correction-note
Description: "A corrected report must include a note explaining the correction."
Severity: #error
Expression: "status = 'corrected' implies note.text.exists()"

Invariant: lab-report-release-time
Description: "The report release must include both date and time."
Severity: #error
Expression: "toString().contains('T')"
