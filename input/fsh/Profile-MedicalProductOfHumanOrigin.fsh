Profile: MedicalProductOfHumanOrigin
Parent: BiologicallyDerivedProduct
Id: medicalproductofhumanorigin
Title: "MedicalProductOfHumanOrigin"
Description: "This profile is designed for biologically derived products that are derived from a human donor and intended for clinical application in a human recipient. Donor and recipient might, or might not, be the same individual. Products of this nature are referred to as medical products of human origin (MPHO) and have specific traceability requirements to ensure that the bi-directional link between donor and recipient is maintained. The profile specifies the essential identifiers for traceability as required elements."

* ^url = "http://hl7.org/fhir/StructureDefinition/medicalproductofhumanorigin"
* ^version = "6.0.0"
* ^status = #draft
* ^experimental = false
* ^date = "2024-10-08T00:00:00+00:00"
* ^publisher = "HL7 International / Orders and Observations"

* ^contact.telecom.system = #url
* ^contact.telecom.value = "http://www.hl7.org/Special/committees/orders/index.cfm Orders and Observations"

* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm].valueInteger = 1
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-wg].valueCode = #oo
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status].valueCode = #draft

* ^mapping[0].identity = "workflow"
* ^mapping[=].uri = "http://hl7.org/fhir/workflow"
* ^mapping[=].name = "Workflow Pattern"

* ^mapping[+].identity = "sct-concept"
* ^mapping[=].uri = "http://snomed.info/conceptdomain"
* ^mapping[=].name = "SNOMED CT Concept Domain Binding"

* ^mapping[+].identity = "v2"
* ^mapping[=].uri = "http://hl7.org/v2"
* ^mapping[=].name = "HL7 V2 Mapping"

* ^mapping[+].identity = "rim"
* ^mapping[=].uri = "http://hl7.org/v3"
* ^mapping[=].name = "RIM Mapping"

* ^mapping[+].identity = "w5"
* ^mapping[=].uri = "http://hl7.org/fhir/fivews"
* ^mapping[=].name = "FiveWs Pattern Mapping"

* ^mapping[+].identity = "sct-attr"
* ^mapping[=].uri = "http://snomed.org/attributebinding"
* ^mapping[=].name = "SNOMED CT Attribute Binding"

* ^mapping[+].identity = "ISBT128Code"
* ^mapping[=].uri = "https://www.isbt128.org/uri/"
* ^mapping[=].name = "ISBT 128 Codes"

* . ^short = "Medical Product of Human Origin Profile"
* . ^definition = "This profile is designed for biologically derived products that are derived from a human donor and intended for clinical application in a human recipient. Donor and recipient might, or might not, be the same individual. Products of this nature are referred to as medical products of human origin (MPHO) and have specific traceability requirements to ensure that the bi-directional link between donor and recipient is maintained. The profile specifies the essential identifiers for traceability as required elements."

* productCategory 1..*
* productCategory ^slicing.discriminator.type = #value
* productCategory ^slicing.discriminator.path = "$this"
* productCategory ^slicing.rules = #open

* productCategory contains MPHOCode 1..1

* productCategory[MPHOCode] = http://hl7.org/fhir/product-category#mpho

* productCode 1..1
* productCode.coding 1..*
* productCode.coding.system 1..1
* productCode.coding.code 1..1

* productCode ^mapping[+].identity = "ISBT128Code"
* productCode ^mapping[=].map = "Product Description Code. Required for ISBT 128 labeled products"

* identifier 1..*
* identifier ^short = "Under most circumstances an MPHO will be uniquely identified using a single identifier from production to point of use. In some cases, a second identifier may be required (for example, import from another country that uses a different identification coding system). In these cases, both the original and new identifier must be included."

* identifier.system 1..1
* identifier.system ^short = "Identity of the Issuing Agency responsible for the allocation of unique identifiers"

* identifier.value 1..1
* identifier.value ^short = "Unique identifier of the MPHO item"

* biologicalSourceEvent 1..1

* biologicalSourceEvent.system 1..1
* biologicalSourceEvent.system ^short = "Identity of the Issuing Agency responsible for the allocation of unique identifiers"

* biologicalSourceEvent.value 1..1
* biologicalSourceEvent.value ^short = "Unique identifier of the donation, collection or pooling event from which the MPHO item was derived"