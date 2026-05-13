Instance: example-red-cell-antigen
InstanceOf: MedicalProductOfHumanOrigin
Usage: #example
Description: "Example of a Medical Product of Human Origin representing an irradiated red blood cell product with ISBT 128 coding and red cell antigen characterization."
* meta.profile = "http://hl7.org/fhir/StructureDefinition/medicalproductofhumanorigin"

* productCategory[MPHOCode].coding.system = "http://hl7.org/fhir/product-category"
* productCategory[MPHOCode].coding.code = #mpho
* productCategory[MPHOCode].text = "Medical Product of Human Origin"

* productCode.coding.system = "https://www.isbt128/org/uri/ProductDescriptionCode"
* productCode.coding.code = #E0398
* productCode.text = " RED BLOOD CELLS|CPD-AS5/450mL/refg|Irradiated|ResLeu: Less than 5E6"

* identifier.system = "https://www.isbt128.org/uri/MPHOUniqueIdentifier"
* identifier.value = "00000E0398A999924123456A00000"

* biologicalSourceEvent.system = "https://www.isbt128.org/uri/DonationIdentificationNumber"
* biologicalSourceEvent.value = "A999924123456"

* division = "A00000"
* expirationDate = "2024-02-02T23:59:00-05:00"

* property[+].type.coding.system = "https://www.isbt128.org/uri"
* property[=].type.coding.code = #RedCellAntigen
* property[=].valueCodeableConcept.coding.system = "https://www.isbt128.org/uri/RedCellAntigen"
* property[=].valueCodeableConcept.coding.code = #0040020206
* property[=].valueCodeableConcept.coding.display = "C+"

* property[+].type.coding.system = "https://www.isbt128.org/uri"
* property[=].type.coding.code = #RedCellAntigen
* property[=].valueCodeableConcept.coding.system = "https://www.isbt128.org/uri/RedCellAntigen"
* property[=].valueCodeableConcept.coding.code = #0040040106
* property[=].valueCodeableConcept.coding.display = "c-"

* property[+].type.coding.system = "https://www.isbt128.org/uri"
* property[=].type.coding.code = #RedCellAntigen
* property[=].valueCodeableConcept.coding.system = "https://www.isbt128.org/uri/RedCellAntigen"
* property[=].valueCodeableConcept.coding.code = #0040030106
* property[=].valueCodeableConcept.coding.display = "E-"

* property[+].type.coding.system = "https://www.isbt128.org/uri"
* property[=].type.coding.code = #RedCellAntigen
* property[=].valueCodeableConcept.coding.system = "https://www.isbt128.org/uri/RedCellAntigen"
* property[=].valueCodeableConcept.coding.code = #0040050206
* property[=].valueCodeableConcept.coding.display = "e+"

* property[+].type.coding.system = "https://www.isbt128.org/uri"
* property[=].type.coding.code = #RedCellAntigen
* property[=].valueCodeableConcept.coding.system = "https://www.isbt128.org/uri/RedCellAntigen"
* property[=].valueCodeableConcept.coding.code = #0060010106
* property[=].valueCodeableConcept.coding.display = "K-"