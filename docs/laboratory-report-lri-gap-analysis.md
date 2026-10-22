# Laboratory report content: LRI gap analysis

Analysis date: 2026-10-22

## Evidence and limits

The intended comparison baseline is **HL7 Version 2.5.1 Laboratory Results Interface (LRI), Edition 5, US Realm, with December 2024 errata**, as listed by HL7 [S1]. Its full download requires an HL7 login and was not available for this review. Consequently, this is a content-focused gap analysis using the accessible primary sources below, not an exhaustive Edition 5 conformance crosswalk. No Edition 5 usage, cardinality, predicate, terminology binding, or numbered conformance statement is asserted unless the source was actually inspected.

The implemented changes are local FHIR design decisions informed by the evidence. They do not make these profiles a translation of LRI or establish LRI, CLIA, or CAP compliance. A complete comparison must identify the applicable LRI profile components as well as the edition.

| Source | Version and use |
| --- | --- |
| [S1: HL7 LRI product record](https://www.hl7.org/implement/standards/product_brief.cfm?product_id=279) | Establishes the named Edition 5 baseline, US Realm, OO ownership, and broad reporting scope. Full specification not inspected. |
| [S2: HL7 OBX-to-Observation map](https://www.hl7.org/fhir/uv/v2mappings/STU1/ConceptMap-segment-obx-to-observation.html) | Version 1.0.0, STU1, informative/experimental, based on FHIR R4. Supports field-level correspondence, not LRI-specific mandatory rules. |
| [S3: HL7 OBR-to-DiagnosticReport map](https://www.hl7.org/fhir/uv/v2mappings/STU1/ConceptMap-segment-obr-to-diagnosticreport.html) | Same mapping release. Legacy identifier mappings require review against R6 semantics. |
| [S4: HL7 SPM-to-Specimen map](https://www.hl7.org/fhir/uv/v2mappings/STU1/ConceptMap-segment-spm-to-specimen.html) | Same mapping release. R6 uses `collection.bodyStructure`, not the R4 `collection.bodySite` path. |
| [S5: NIST LRI validation suite](https://hl7v2-lab-testing.nist.gov/mu-lab/) | Historical suite version 1.7.2, dated 2015-03-20. Public scenarios include final, corrected, rejected, panel, culture/susceptibility, and reflex results. This is not Edition 5 validation evidence. |
| [S6: HL7 USLab report guidance](https://hl7.org/fhir/DSTU2/uslab/uslabreport-guide.html) | Historical DSTU2 guidance. Provides related reporting context, vocabulary and correction considerations; it is not the current LRI specification or an R6 implementation recipe. |

FHIR paths and permissible constraints were also checked against the locally configured `hl7.fhir.r6.core#6.0.0-snapshot1` package. [Design intent](laboratory-report-design-intent.md) records the original scope and required-value decision.

## Findings and dispositions

“Implemented” below means a change to these incubator profiles, not verified equivalence to a particular LRI conformance statement. “Partial” identifies work deliberately left visible.

| Topic and evidence | Gap in the initial profiles | Disposition in this iteration |
| --- | --- | --- |
| Business identity and reconciliation: order numbers in the reporting workflow [S3, S5]; individual observation identity, OBX-21 [S2]; specimen identity, SPM-2 [S4] | Report, result, order, and specimen could all lack business identifiers. Resource URLs alone did not express issuing namespaces or correction identity. | **Implemented:** require at least one `identifier` with `system` and `value` on all four resources. This uniform requirement is a local design choice. Preserve placer/filler order identifiers on ServiceRequest, and keep report, result, and specimen identities distinct. |
| Test identity: OBX-3 and OBR-4 [S2, S3]; standard vocabulary context [S6] | Text-only test or specimen concepts could conform. | **Implemented:** require system/code pairs for report, result, component, order test, and specimen type. Support supplied text and preserve local coding alongside standard coding. **Partial:** no claim to the full LRI value-set or LOINC conditional requirements. |
| Clinically relevant time: OBX-14 [S2] | Observation effective time was optional, although specimen collection time was present. | **Implemented:** require result `effective[x]`, and require a start when its value is a Period. Keep report effective time supported. This result cardinality is a local decision. |
| Analysis time: OBX-19 maps to the standard analysis-date-time extension [S2] | Collection, result availability, and report release were represented, but instrument analysis time was not. | **Open:** preserve the core-element-only baseline for this pass. Document that `issued` and `effective[x]` are not substitutes for instrument analysis time. Adopting the standard extension needs an explicit dependency and example update. |
| Result interpretation and method: OBX-8 and OBX-17 [S2] | These elements existed in core but had no profile support expectations. | **Implemented:** Must Support on interpretation and method, including component interpretation. No requirement to invent flags or methods when unavailable or inapplicable. |
| Testing organization and observer roles: OBX-23/24/25 and OBX-16 [S2] | Organization-only performers prevented representation of additional practitioner roles. | **Implemented:** retain a required Organization performer slice for the testing laboratory while allowing Practitioner and PractitionerRole performers. **Partial:** this does not reproduce every v2 role distinction or enforce director identity. |
| Specimen detail: collection method, source site, receipt, availability, condition [S4] | Only specimen type, collection time, and condition/note support were specified. | **Implemented:** Must Support on collection method, R6 anatomic source, received time, and specimen status. Preserve existing condition/note support. **Partial:** type modifiers, rejection details, and processing-specific data need further modeling. |
| Corrections are distinct test scenarios [S5]; related historical reporting guidance [S6] | No explicit support expectations for explanation or prior-report relationships. | **Implemented:** support report notes and `relatesTo`; require a note on a report or result whose status is `corrected`. This explanatory-note rule is a local policy, not an attributed LRI predicate. Stable business identity is documented. **Partial:** full replacement, notification, retention, and version processing remain workflow work. |
| Rejected tests are explicit historical LRI test scenarios [S5] | The required-value profile could not represent an unperformed test, and the initial scope did not explain where its reason should go. | **Deliberate boundary:** keep required values and prohibit Data Absent Reason, including components. Support order status reasons and notes and specimen status. Do not map every specimen rejection to an order cancellation automatically. A full rejected-test reporting pattern remains open. |
| Panels, culture/susceptibility, reflex relationships [S5]; OBX grouping is context dependent [S2] | No valueless organizer profile or multi-level example exists. | **Open:** individual value-bearing results may appear together in a report. Do not claim that this implements LRI panel or microbiology relationships. A separate organizer design must preserve the existing result profile's required-value rule. |
| Numeric and nonnumeric results [S2] | Quantity constraints existed, but their scope could be mistaken for all quantitative datatypes. | **Retained/clarified:** Quantity and component Quantity values require numeric values and UCUM units. CodeableConcept, boolean false, zero, and other actual values remain available. Range/Ratio/SampledData unit rules need further review. |
| Supporting patient, provider, and laboratory content [S1, S6] | Administrative resources remained unprofiled; comments alone did not validate their required details. | **Open within the OO-only boundary:** retain documented expectations. Do not claim names, physical addresses, CLIA identifiers, authorization, or patient matching are enforced by these four profiles. |
| Exchange and receiving-system behavior [S1, S5] | A collection Bundle had no interface choreography or receiver behavior contract. | **Out of this content-profile iteration:** acknowledgments, transport, preservation, clinician display, error handling, critical-result notification, and delivery remain implementation responsibilities. |

## Mapping cautions carried into the design

The published mapping material is informative and based on R4. It cannot be applied mechanically to R6. In particular, the older OBR map places order numbers on DiagnosticReport identifiers. This iteration keeps placer/filler **order** identifiers on ServiceRequest and gives DiagnosticReport its own report identifier, consistent with the configured R6 definitions. An implementation converting v2 must preserve the source identifiers and associations without changing their meaning.

Likewise, R4 Organization address and Specimen collection-site paths must be translated to the configured R6 structures. Specimen rejection mapping in the published SPM material is explicitly unresolved; its mention of `ServiceRequest.dataAbsentReason` is not an available path in this R6 package. The profiles use the actual R6 `ServiceRequest.statusReason` and notes for support, without pretending to define a complete rejection conversion.

## Source changes and example

All four [profile sources](../input/fsh/) were updated. The [example Bundle](../input/examples/bundle-clia-report.json) now supplies distinct report, result, order, and specimen business identifiers. Its specimen type is coded, and availability and receipt time are populated. Existing patient, order, laboratory attribution, specimen collection, result value, and report release information is retained.

The example remains a final potassium report. It does not demonstrate every newly supported optional field or a corrected/rejected/panel workflow. No new administrative profile, Bundle profile, or extension was added.

## Completion criteria for the full LRI comparison

Obtain the Edition 5 specification with December 2024 errata and record the exact component combination being evaluated. Extend this matrix with section/field identifiers, usage codes, conditional predicates, bindings, and corresponding FHIR constraints. Classify each as equivalent, intentionally stronger, intentionally narrower, documented only, or unsupported. Pay particular attention to specimen rejection, partial/final/corrected reporting, narrative results, hierarchy, responsible observer/medical director roles, identifier uniqueness, terminology translations, and analysis timestamps.

Use representative LRI messages and FHIR instances to test content preservation and associations. Keep value-less and Data Absent Reason-only Observations as negative cases for Laboratory Result Content. A complete LRI converter will need additional patterns for messages outside this result profile's scope.

## Validation of this iteration

SUSHI 3.21.0 compiled the changes with zero errors and one warning about prerelease FHIR support. Targeted checks used the generated differentials for required fields, cardinalities, reference targets, performer/category slice presence, and fixed values. The generated correction-note and release-time expressions were evaluated using fhirpath.js 5.2.1 with its R5 context model; the exercised expressions use paths and operations also present in the configured R6 resources.

All four profiled Bundle entries passed these checks, and every resource reference resolved within the Bundle. Eighteen mutation cases exercised missing values, DAR-only results/components, absent identifiers/namespaces/coded identity/observation time, missing units, observer-only versus laboratory-plus-observer performers, qualitative results, boolean false, numeric zero, corrected reports/results with and without notes, and a date-only report release. The correction invariant checks that note text is present; deciding whether that text adequately explains the correction still requires semantic review. The checks were run in memory and are not a committed regression suite.

Java was not available on PATH, so a full FHIR validator and IG Publisher run was not performed in this iteration. Compilation and targeted structural checks are not full instance validation, and historical NIST scenarios do not validate these R6 profiles. Before publication, run the validator and Publisher, review terminology and slice-validation behavior, and validate the new correction and performer patterns in representative examples.
