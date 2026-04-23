# OO Incubator

The Orders & Observations (OO) Incubator Implementation Guide serves as a consolidated workspace for emerging specifications, including FHIR resources, profiles, operations, vocabularies, and artifacts developed by the [HL7 Orders & Observations Work Group](https://www.hl7.org/Special/committees/orders/index.cfm). It includes resources that are actively evolving and have not yet reached normative status under the [FHIR Maturity Model](https://build.fhir.org/versions.html#std-process), but may still be suitable for trial use, pilot implementations, and even production deployments where appropriate. These artifacts reflect the current direction of ongoing work but should not be interpreted as stable normative specifications.

Implementers may choose to use these artifacts for trial use, pilot testing, or even production deployments, but should do so with the understanding that:

* Artifacts may change significantly as they progress through the FHIR Maturity Model
* Backward compatibility is not guaranteed
* Items may be promoted into official HL7 balloted specifications, or removed if superseded or no longer aligned with Work Group direction
* Implementer feedback is a critical input and may directly influence future revisions

This IG defines the scope of exploration for the Orders & Observations Work Group and provides early visibility into emerging content. Implementers are encouraged to assess their risk tolerance, track updates regularly, and participate in the standards development process where possible.

## Migrated Resources

<table class="grid">
{% include table-name-structuredefinitions-en.xhtml %}
</table>

## Migrated Profiles (that do not have a parent Resource in the Incubator)

{% comment %}
<!-- This is causing IG publisher to hang, for now, render pure HTML instead. -->
<table class="grid">
{% include table-name-profiles-en.xhtml %}
</table>
{% endcomment %}

<table class="grid">
  <thead>
    <tr>
      <th>Profile</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>MedicalProductOfHumanOrigin</td>
      <td>This profile is designed for biologically derived products that are derived from a human donor and intended for clinical application in a human recipient. Donor and recipient might, or might not, be the same individual. Products of this nature are referred to as medical products of human origin (MPHO) and have specific traceability requirements to ensure that the bi-directional link between donor and recipient is maintained. The profile specifies the essential identifiers for traceability as required elements.</td>
    </tr>
  </tbody>
</table>