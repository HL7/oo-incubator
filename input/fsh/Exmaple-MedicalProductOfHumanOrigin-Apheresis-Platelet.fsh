Instance: example-apheresis-platelet
InstanceOf: MedicalProductOfHumanOrigin
Usage: #example
Description: "Example of a Medical Product of Human Origin representing an irradiated leukocyte-reduced apheresis platelet product identified using ISBT 128 coding."
* meta.profile = "http://hl7.org/fhir/StructureDefinition/medicalproductofhumanorigin"

* productCategory[MPHOCode].coding.system = "http://hl7.org/fhir/product-category"
* productCategory[MPHOCode].coding.code = #mpho
* productCategory[MPHOCode].text = "Medical Product of Human Origin"

* productCode.coding.system = "https://www.isbt128.org/uri/ProductDescriptionCode"
* productCode.coding.code = #E3046
* productCode.text = "Apheresis Platelets, Irradiated, Leukocyte reduced"

* identifier.system = "https://www.isbt128.org/uri/MPHOUniqueIdentifier"
* identifier.value = "00000E3046A999924123457000000"

* biologicalSourceEvent.system = "https://www.isbt128.org/uri/DonationIdentificationNumber"
* biologicalSourceEvent.value = "A999924123457"

* division = "000000"
* expirationDate = "2024-02-02T23:59:00-05:00"