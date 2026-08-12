# Transport Examples — Migration Notes

How the four OO Work Group Transport review scenarios went from their original
R5 form (the resources behind the Confluence diagrams) to the finished, publishing
R6 examples in this Implementation Guide.

## Starting point

The review set contained four Transport scenarios, each authored against the
**published R5 `Transport` resource** and shipped in two packagings:

- `fhir-build/` — one root `Transport` per scenario with all supporting resources
  (Patients, Specimens, Devices, Locations, Observations) held as **`contained`**
  resources, so each example could be understood and validated without external
  references.
- Scenario **`Bundle`s** (type `collection`) — the same resource graph exposed as
  ordinary Bundle entries, intended for loading into a test server.

Each scenario corresponds to one of the Confluence diagrams:

| # | Diagram | Scenario |
|---|---------|----------|
| 01 | Patient, specimen, tube, and bag | Courier pickup of a specimen bag |
| 02 | External multi-patient cooler shipment with temperature measurements | Inter-facility cooler shipment |
| 03 | In-laboratory movement workflow | Four-leg specimen route |
| 04 | Tray movement with nested racks and tubes | Tray moved to cold storage |

## Why the examples couldn't be used as-is

Two facts drove every change:

1. **This IG *redefines* the Transport resource for R6.**
   `input/resources/transport/StructureDefinition-Transport.xml` is a
   `specialization` from `DomainResource`, published at the **same canonical URL**
   as base Transport. So examples are validated against the WG's proposed R6
   Transport — which uses `from` / `to` / `period` and has **removed**
   `currentLocation`, `requestedLocation`, `completionTime`, `input`, `output`,
   and `intent`. The R5 examples used all of those.

2. **FHIR's `dom-3` / `ref-1` rules make fully self-contained multi-item examples
   impossible here.** A `contained` resource must be reachable from the root by
   following references (or refer back to the container), and a `#fragment`
   reference may only resolve to another *contained* resource — never to the root.
   Because the redefined Transport has no multi-item element and only single-valued
   `focus` / `subject`, the transported items (which reference *up* the device tree)
   are unreachable from the root and fail `dom-3`.

## What we changed

### 1. Chose the bare `Transport` resources over the Bundles

The `fhir-build/` `Transport` files register as `Transport/<id>` tied to the profile
(like the existing `simpledelivery` example) and are profile-validated. The
collection Bundles are opaque to the validator and can't carry an
`exampleCanonical`, so they were not used for publishing.

### 2. Converted R5 elements to the R6 redefinition

| R5 element | R6 (incubator) | Notes |
|------------|----------------|-------|
| `currentLocation` | `from` | Originating location |
| `requestedLocation` | `to` | Destination location |
| `completionTime` | `period` | `period.end` = completion; `period.start` = `authoredOn` where present |
| `intent` | — | Removed in the redefinition |
| `for` | `subject` | Beneficiary (patient) |
| `history` | `priorTransport` | Prior leg in a chain |
| `input` / `output` | — | No equivalent; handled by un-containing (below) |

Element order was matched to the redefinition's canonical order, and each instance
carries the required `resourceDefinition="…/Transport|0.1.0"` root attribute.

### 3. Un-contained the supporting resources

To satisfy `dom-3`, every contained resource was extracted into its own top-level
example file. References changed from `#id` fragments to `Type/id`, and ids were
**namespaced per example** (`t01-`…`t04-`) because several collided across scenarios
(`tube-61` appeared in 01 and 04; `tray-42` in 03 and 04). This also matches the
original README's own guidance that real implementations keep resources
independently addressable.

Un-containing additionally *restored* the relationships that `input` / `output`
used to express, using idiomatic references that now resolve cleanly:

- **Example 02** — the three cold-chain temperature `Observation`s link back to the
  shipment via `Observation.focus → Transport/transport-example-02-external-shipment`.
- **Example 03** — the four movement legs are standalone `Transport` resources
  chained by `priorTransport` (route → leg 4 → leg 3 → leg 2 → leg 1).
- **Examples 01 / 04** — the manifest is implicit in the `Device.parent` hierarchy
  (tube → rack → bag/tray), with `Transport.focus` on the moved container.

### 4. Registered the instances

All eight `Transport` instances (four scenarios + four legs) are registered in
`sushi-config.yaml` with `exampleCanonical`. The 38 remaining supporting resources
are picked up by the publisher's resource scan.

## Finished examples

- **`transport-example-01-sample-collection`** — a specimen bag (2 patients' tubes)
  moved from a pickup point to a courier depot.
- **`transport-example-02-external-shipment`** — a temperature-controlled cooler
  shipment between facilities, with in-transit temperature Observations.
- **`transport-example-03-laboratory-workflow`** — an overall in-lab route composed
  of four `priorTransport`-chained legs.
- **`transport-example-04-tray-movement`** — a tray with nested racks and tubes
  moved to cold storage.

## Build status and known noise

The examples build and validate with **no genuine structural errors**. Two error
classes remain in `qa.txt` that are **not** caused by these examples:

- **Broken anchor links** (`StructureDefinition-Transport.html#Transport.id|language|text`)
  — the redefined Transport StructureDefinition page doesn't expose base-element
  anchors, so example pages can't link to them. The pre-existing `simpledelivery`
  example produces the identical set; fixing it is a change to the StructureDefinition,
  not the examples.
- **Terminology-server errors** (`tx.fhir.org` cache "not known to this server",
  `validate-code` timeouts) — transient session failures that vary run-to-run.

## Follow-ups (out of scope here)

1. Expose base-element anchors on `StructureDefinition-Transport` to clear the
   broken-link class across all Transport examples.
2. Re-run against a healthy terminology server to clear the `tx.fhir.org` errors.
