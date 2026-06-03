Instance: example-apheresis-platelet
InstanceOf: MedicalProductOfHumanOrigin
Usage: #example
Description: "Example of a Medical Product of Human Origin representing an irradiated leukocyte-reduced apheresis platelet product identified using ISBT 128 coding."
* meta.profile = "http://hl7.org/fhir/StructureDefinition/medicalproductofhumanorigin"

* productCategory[0].coding.system = "http://hl7.org/fhir/product-category"
* productCategory[0].coding.code = #mpho
* productCategory[0].text = "Medical Product of Human Origin"

* productCode.coding.system = "https://www.isbt128.org/uri/productdescriptioncode"
* productCode.coding.code = #E3046
* productCode.text = "Apheresis Platelets, Irradiated, Leukocyte reduced"

* identifier[MPHOUniqueIdentifier].system = "https://www.isbt128.org/uri/mphouniqueidentifier"
* identifier[MPHOUniqueIdentifier].value = "00000E3046A999924123457000000"

* biologicalSourceEvent.system = "https://www.isbt128.org/uri/donationidentificationnumber"
* biologicalSourceEvent.value = "A999924123457"

* division = "000000"
* expirationDate = "2024-02-02T23:59:00-05:00"
