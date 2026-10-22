# Laboratory report content: design intent

Recorded: 2026-10-22

This document preserves the context and decisions behind the initial laboratory report example and profiles. It is a maintainer design record for further iteration. The FSH files define the implemented constraints; this document explains their purpose and identifies work that remains.

## Purpose and origin

The starting request was to demonstrate minimum viable laboratory report content in an Observation-centered, self-contained FHIR Bundle. The discussion then expanded to reusable profiles for resources owned by the HL7 Orders and Observations (OO) Work Group, following the authoring conventions of the existing Medical Product of Human Origin profile.

The initiating discussion is [Draft FHIR CLIA Bundle](https://chatgpt.com/share/e/6ada3d1b-3e90-8325-a476-ece991d67cf0). The requirements and decisions needed to continue the work are recorded here so that future maintainers do not need access to that chat.

The work explores the representation of CLIA/CAP report content. It does not claim that conformance to these profiles establishes regulatory or accreditation compliance. The supplied CAP requirements did not identify a checklist edition or item number. Before making formal compliance claims, establish the applicable authoritative requirements and their versions, and distinguish content requirements from operational obligations.

## LRI-informed revision

The [LRI gap analysis](laboratory-report-lri-gap-analysis.md) records the follow-up comparison and its source limitations. LRI is a requirements baseline for this work, but the full Edition 5 specification requires authenticated access and was not inspected. Implemented lessons from accessible HL7 mappings and historical NIST LRI test scenarios must not be represented as verified Edition 5 conformance.

The revision requires distinct business identifiers on report, result, specimen, and order; requires coded test and specimen identity; requires clinically relevant result timing; and adds support for interpretation, methods, specimen receipt and anatomic source, and correction context. Corrected reports and results require explanatory notes. These are explicit local content decisions. They do not reproduce all LRI cardinalities or predicates.

Observation performer references now use an open slice requiring at least one testing-laboratory Organization, while permitting additional Practitioner and PractitionerRole references for observer roles. Patient and administrative-resource content remains outside mechanical enforcement. Instrument analysis time is a separate outstanding gap: it must not be substituted into result availability or clinically relevant time, and adding its standard extension would change the current core-element-only baseline.

## Requirements being represented

The supplied report-content requirements were:

| Requirement | Intended representation |
| --- | --- |
| Testing laboratory name and address | `Observation.performer` identifies the actual testing `Organization`, with its name and physical address in `Organization.name` and `Organization.contact.address`. |
| Patient name and identification number | `Patient.name` and `Patient.identifier`, reached through the report and result subject references. |
| Ordering physician or other legally authorized ordering person's name | `ServiceRequest.requester` identifies a `Practitioner`, directly or through `PractitionerRole`. |
| Specimen collection date and, when appropriate, time | `Specimen.collection.collected[x]`. A collection period must include its start. |
| Report release date | `DiagnosticReport.issued`. |
| Report release time, when applicable | The initial profile requires both date and time in `DiagnosticReport.issued`. |
| Specimen source, when applicable | The initial serum example uses `Specimen.type`. More specific source or collection-site requirements need further examination. |
| Test results and units, when applicable | `Observation.code` and `Observation.value[x]`; Quantity results include numeric values and UCUM units. |
| Reference intervals, as applicable | `Observation.referenceRange`, or `Observation.component.referenceRange` for components. |
| Specimen conditions that may limit testing adequacy | `Specimen.condition` and `Specimen.note`, with result-specific effects in `Observation.note`. |

The supplied requirements also state that these details must be available to the clinician in the transmitted or accessible report. Electronic presentation may span screens, but the information must remain readily available. Including resources in a Bundle is only the content representation; it does not demonstrate that a receiving application presents them appropriately.

The referral-laboratory requirement includes the name and address of each laboratory where testing was performed, including separately accredited affiliated laboratories with different CLIA registration numbers. The example includes distinct fictional CLIA identifiers to make the two laboratory identities explicit. It does not impose a universal CLIA-identifier cardinality requirement.

## Artifact and ownership boundaries

The four profiles are defined as FSH under `input/fsh/`:

| Profile | Source | Responsibility |
| --- | --- | --- |
| Laboratory Report Content | [Profile-LaboratoryReportContent.fsh](../input/fsh/Profile-LaboratoryReportContent.fsh) | Report context, release timestamp, reporting laboratory, and links to orders, specimens, and results. |
| Laboratory Result Content | [Profile-LaboratoryResultContent.fsh](../input/fsh/Profile-LaboratoryResultContent.fsh) | Individual result with a required value and testing laboratory attribution. |
| Laboratory Specimen Content | [Profile-LaboratorySpecimenContent.fsh](../input/fsh/Profile-LaboratorySpecimenContent.fsh) | Specimen type, collection date, order link, and support for testing limitations. |
| Laboratory Order Content | [Profile-LaboratoryOrderContent.fsh](../input/fsh/Profile-LaboratoryOrderContent.fsh) | Requested test, patient, and ordering practitioner. |

The canonical base is `http://hl7.org/fhir/uv/oo-incubator/StructureDefinition/`, with IDs `laboratory-report-content`, `laboratory-result-content`, `laboratory-specimen-content`, and `laboratory-order-content`. The initial profiles use OO ownership, FMM 1, Trial-Use status, and the IG version `0.1.0-snapshot`. The configured FHIR release is `6.0.0-snapshot1`; check `sushi-config.yaml` when updating this baseline.

`Patient`, `Practitioner`, `PractitionerRole`, `Organization`, and `Bundle` remain unprofiled. Their supporting-content expectations are documented on references. The four OO profiles alone do not enforce names, identifiers, addresses, practitioner-role resolution, or authorization in those resources. Any proposal to add administrative-resource profiles should explicitly revisit this ownership boundary.

The report's references target the order, specimen, and result profiles. Result and specimen references also target the order profile. This creates a reusable set of related resource profiles rather than a single Bundle profile.

## Decisions to preserve

### Results must contain values

The user explicitly required that an Observation containing only a Data Absent Reason must not conform. The initial implementation therefore sets:

```fsh
* value[x] 1..1
* dataAbsentReason 0..0
* component.value[x] 1..1
* component.dataAbsentReason 0..0
```

This is a deliberate boundary for this report-content profile. Do not relax it to permit `value[x]` or `dataAbsentReason` as alternatives without revisiting the requirement with the authors. This design record does not independently establish a legal interpretation of every absent-result scenario.

Nonnumeric results remain permitted. A qualitative result, a numeric zero, or a boolean `false` can be a real value. A cancelled, unperformed, or unavailable test must not be represented by inventing a value to satisfy this profile. Modeling those cases is future work and must preserve the required-value boundary for resources claiming conformance to Laboratory Result Content.

The same rule excludes a panel organizer without its own value, including an Observation with only `hasMember` or only components. `DiagnosticReport.result` currently targets Laboratory Result Content, so this initial design also does not support valueless organizers through that reference. Panel support requires an explicit design decision, potentially a separate organizer profile.

### Quantitative and conditional content

Quantity-valued results and components require `value`, `unit`, `system`, and `code`, with the system fixed to UCUM. The quantity slice remains optional: these constraints must not make every result a Quantity. The initial implementation does not apply equivalent constraints to all other result datatypes, such as Range or Ratio.

Reference intervals and specimen limitations remain conditional. They are marked Must Support rather than universally mandatory. As documented on the profiles page, producers must be able to record and supply the marked information when applicable; receivers must be able to retain it and make it available to the clinician. Do not manufacture reference intervals or specimen limitations when none applies. Must Support alone does not mechanically determine applicability for a particular test.

### Reporting and testing laboratory roles

`DiagnosticReport.performer` identifies the laboratory responsible for issuing the report. `Observation.performer` identifies the laboratory that actually performed that individual test. The example intentionally assigns these roles to different organizations to demonstrate a referral case.

The example assumes that the referral laboratory returns the result to the referring laboratory, which releases the report to the clinician. The Bundle does not model delivery acknowledgments or prove that this workflow occurred. A single laboratory may fill both roles in other examples.

Business identifiers are required on all four profiled resources and must include an assigning system and value. Placer/filler order identifiers belong on ServiceRequest; they must not be copied onto DiagnosticReport as if they identified the report. Corrected versions of the same report or result preserve business identity. A new report related to an earlier one can use DiagnosticReport.relatesTo; the complete correction delivery and retention workflow remains to be specified.

`DiagnosticReport.issued` is the report release timestamp. `Observation.issued` is the availability timestamp of the individual result. The example uses different timestamps to preserve that distinction. The report profile's additional invariant requires a time component; broader timestamp validity remains subject to the base datatype and validator.

## Example and publication structure

[bundle-clia-report.json](../input/examples/bundle-clia-report.json) is a `collection` Bundle containing eight resources: one Observation, DiagnosticReport, ServiceRequest, Specimen, Patient, and Practitioner, plus two Organizations. Every resource reference resolves to a Bundle entry's `fullUrl`. The four OO resources declare their corresponding profiles in `meta.profile`.

The example uses a serum potassium result, an elevated value, an illustrative reference interval, and slight hemolysis with a result-specific limitation. All identities, identifiers, addresses, and clinical values are illustrative. Future profiles must not be narrowed to potassium, serum, hemolysis, or referral testing merely because these are used in the first example.

The report narrative assembles readable content, while structured elements retain the same information for processing. Keep narrative and structured content consistent when changing the example.

Related publication sources are:

- [Bundle-clia-report-intro.xml](../input/pagecontent/Bundle-clia-report-intro.xml): example design explanation and numbered requirement mapping.
- [examples.md](../input/pagecontent/examples.md): discovery link to the example.
- [profiles.md](../input/pagecontent/profiles.md): profile overview, Must Support meaning, and separate laboratory/other profile tables.
- [sushi-config.yaml](../sushi-config.yaml): example registration, profile navigation, and IG metadata.

The profile-table SQL selects resource constraints and partitions them using `Name LIKE 'Laboratory%'` and `Name NOT LIKE 'Laboratory%'`. New laboratory profiles should retain that naming convention or update both queries together. The existing Medical Product of Human Origin profile belongs in the other-profiles table.

Edit authored sources under `input/` and configuration files. Regenerate `fsh-generated/` and `output/`; do not treat generated files as the authoring source.

## Questions for the next iteration

1. Establish the authoritative CLIA/CAP requirement versions and decide whether these profiles describe a general laboratory content baseline or a particular reporting use case. Several initial cardinalities are intentionally stronger than the supplied "when applicable" language, including mandatory specimen and order references and a report release time.
2. Decide how to enforce supporting Patient, Practitioner/PractitionerRole, and Organization content while respecting the OO scope. Document whether conformance depends on additional profiles, resolution-aware invariants, or implementation obligations.
3. Add panel and multi-test cases, including multiple specimens, multiple testing laboratories, and reports combining local and referral results. Preserve attribution for each result and define whether organizers need a separate profile.
4. Define complete cancelled, pending, unavailable, and corrected-result workflows. Corrected reports and results now require explanatory notes, and prior-report relationships are supported, but replacement, notification, retention, and rejected-test patterns remain open. The profiles do not restrict status to final reports; requiring a value still applies regardless of status. Do not weaken the required-value rule implicitly when adding lifecycle examples.
5. Review units and reference intervals across result datatypes. Consider dimensionless results, qualitative reference text, age- or method-dependent intervals, and components with their own limitations.
6. Examine source and collection modeling beyond serum: anatomic site, specimen processing, collection periods, and tests for which collection time or source has different applicability.
7. Decide which relationships need explicit consistency checks. The initial profiles do not enforce that all referenced patients match, that every result uses a specimen listed on its report, or that collection, result, and release timestamps occur in order.
8. Check whether primitive extensions or partially populated complex values could satisfy cardinality without conveying an actual result. Requiring `value[x]` is the starting rule; stronger semantic validation may be needed without excluding legitimate result types.
9. Keep critical-result notification, authorized release, referral delivery, audit trails, corrections, retention, and clinician-facing presentation visible as implementation work. A resource profile cannot demonstrate those processes by itself.

## Validation baseline and continuation

During initial development, SUSHI 3.21.0 compiled the four profiles with zero errors and one warning about prerelease FHIR support. Targeted checks against the generated differentials checked the example's required fields, reference targets, units, category, and release-time rule. They also exercised missing values, Data Absent Reason-only results, components without values, missing units, qualitative results, boolean `false`, and date-only report release. These were targeted checks, not a complete FHIR validator run or a committed regression suite.

Full IG Publisher validation was not run during that initial pass because Java was unavailable on PATH. Treat that as historical validation evidence; recheck available tooling and current QA results before the next change. A successful SUSHI run does not establish full FHIR instance validity, terminology correctness, rendered-link correctness, or conformance of the receiving application.

For future changes, compile the FSH, validate the profiled Bundle entries with a FHIR validator able to resolve the profiles and Bundle references, and run the IG Publisher. Review QA messages and the rendered profile tables and example pages. Retain negative cases proving that missing-value and Data Absent Reason-only results cannot conform, and positive cases showing that legitimate nonnumeric and false/zero values remain supported. Update this record when an intentional design decision changes.
