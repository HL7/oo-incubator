### CLIA Laboratory Report

The [CLIA laboratory report Bundle](Bundle-clia-report.html) demonstrates minimum report content using core FHIR elements, centered on a single potassium Observation. It includes the patient, ordering physician, order, specimen, report, and referring and referral laboratories. The [JSON example](Bundle-clia-report.json.html) is a self-contained collection of eight resources.

The example distinguishes the laboratory responsible for the report (`DiagnosticReport.performer`) from the referral laboratory that performed the test (`Observation.performer`). Both laboratories have names, physical addresses, and distinct fictional CLIA identifiers. See the example page for the requirement mapping and design intent.
