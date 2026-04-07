# OO Incubator

The Orders & Observations (OO) Incubator Implementation Guide serves as a consolidated workspace for emerging specifications, including FHIR resources, profiles, operations, vocabularies, and artifacts developed by the [HL7 Orders & Observations Work Group](https://www.hl7.org/Special/committees/orders/index.cfm). It includes resources that are actively evolving and have not yet reached normative status under the [FHIR Maturity Model](https://build.fhir.org/versions.html#std-process), but may still be suitable for trial use, pilot implementations, and even production deployments where appropriate. These artifacts reflect the current direction of ongoing work but should not be interpreted as stable normative specifications.

Implementers may choose to use these artifacts for trial use, pilot testing, or even production deployments, but should do so with the understanding that:

* Artifacts may change significantly as they progress through the FHIR Maturity Model
* Backward compatibility is not guaranteed
* Items may be promoted into official HL7 balloted specifications, or removed if superseded or no longer aligned with Work Group direction
* Implementer feedback is a critical input and may directly influence future revisions

This IG defines the scope of exploration for the Orders & Observations Work Group and provides early visibility into emerging content. Implementers are encouraged to assess their risk tolerance, track updates regularly, and participate in the standards development process where possible.

## Migrated Resources

| Resource | Description |
| :---- | :---- |
| [BiologicallyDerivedProductDispense](https://build.fhir.org/ig/HL7/oo-incubator/en/StructureDefinition-BiologicallyDerivedProductDispense.html) | A record of dispensation of a biologically derived product. |
| [DeviceDispense](https://build.fhir.org/ig/HL7/oo-incubator/en/StructureDefinition-DeviceDispense.html) | Indicates that a device is to be or has been dispensed for a named person/patient. This includes a description of the product (supply) provided and the instructions for using the device. |
| [DeviceUsage](https://build.fhir.org/ig/HL7/oo-incubator/en/StructureDefinition-DeviceUsage.html) | A record of a device being used by a patient where the record is the result of a report from the patient or a clinician. |
| [InventoryItem](https://build.fhir.org/ig/HL7/oo-incubator/en/StructureDefinition-InventoryItem.html) | functional description of an inventory item used in inventory and supply-related workflows. |
| [InventoryReport](https://build.fhir.org/ig/HL7/oo-incubator/en/StructureDefinition-InventoryReport.html) | A report of inventory or stock items. |
| [SupplyDelivery](https://build.fhir.org/ig/HL7/oo-incubator/en/StructureDefinition-SupplyDelivery.html) | Record of delivery of what is supplied. |
| [SupplyRequest](https://build.fhir.org/ig/HL7/oo-incubator/en/StructureDefinition-SupplyRequest.html) | A record of a non-patient specific request for a medication, substance, device, certain types of biologically derived product, and nutrition product used in the healthcare setting. |
| [Transport](https://build.fhir.org/ig/HL7/oo-incubator/en/StructureDefinition-Transport.html) | Record of transport. |

## Migrated Profiles (that do not have a parent Resource in the Incubator)

| Profile | Description |
| :---- | :---- |
| MedicalProductOfHumanOrigin | This profile is designed for biologically derived products that are derived from a human donor and intended for clinical application in a human recipient. Donor and recipient might, or might not, be the same individual. Products of this nature are referred to as medical products of human origin (MPHO) and have specific traceability requirements to ensure that the bi-directional link between donor and recipient is maintained. The profile specifies the essential identifiers for traceability as required elements. |