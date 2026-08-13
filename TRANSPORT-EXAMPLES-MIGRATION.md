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
| `input` / `output` | — | No equivalent; supporting resources are `contained` and made reachable (below) |

Element order was matched to the redefinition's canonical order, and each instance
carries the required `resourceDefinition="…/Transport|0.1.0"` root attribute.

### 3. Kept the examples self-contained (one file per example)

To keep each example to a single file, all supporting resources (Patients,
Locations, Devices, Specimens, Observations) live **inside the Transport as
`contained` resources**. The challenge is FHIR's `dom-3`: every contained resource
must be reachable from the root by following references, and `ref-1` forbids a
contained resource from referencing its container. Because the redefined Transport
removed `input`/`output` and has only single-valued `focus`/`subject`, two patterns
were used to restore reachability:

- **Reach via a leaf.** `Transport.focus` points at a leaf resource so the validator
  can follow the chain upward — e.g. `focus → specimen → tube → rack → tray`, plus
  `specimen → patient`. This alone covers single-item examples.
- **Provenance hub (examples 01, 02, 04).** Where an example has *multiple* leaf
  items (two specimens, three temperature Observations) that a single `focus` can't
  all reach, each example includes one contained `Provenance` whose `target` lists
  every subordinate resource, linked from `Transport.relevantHistory`. That makes
  everything reachable and doubles as a legitimate audit record of the transport
  handling those resources. Its `agent.who` points at the transporting Device.

### 4. Example 03 as four chained legs (not a contained wrapper)

Example 03 is a multi-hop journey. A hop is a first-class transport event, so the
idiomatic model is **four top-level `Transport` resources chained by
`priorTransport`** (leg 2 → leg 1, leg 3 → leg 2, leg 4 → leg 3), rather than four
sub-Transports contained inside a wrapper. This is also required by the tooling: the
IG publisher cannot attach a `resourceDefinition` to a *contained* instance of a
**redefined** type (Transport-in-Transport), so contained legs always error; as
top-level files they carry `resourceDefinition` like any other example. Each leg is
itself self-contained — it holds its own specimen + device chain, patient, and its
two locations, with `focus → specimen` reaching them all (no Provenance hub needed).

### 5. Registered the instances

The seven top-level `Transport` instances (examples 01, 02, 04 and the four ex03
legs) are registered in `sushi-config.yaml` with `exampleCanonical`.

## Finished examples

- **`transport-example-01-sample-collection`** — a specimen bag (2 patients' tubes)
  moved from a pickup point to a courier depot. Self-contained + Provenance hub.
- **`transport-example-02-external-shipment`** — a temperature-controlled cooler
  shipment with in-transit temperature Observations. Self-contained + Provenance hub.
- **`transport-example-03-leg-1…4-*`** — the in-laboratory workflow as four
  self-contained `Transport` legs chained by `priorTransport`.
- **`transport-example-04-tray-movement`** — a tray with nested racks and tubes
  moved to cold storage. Self-contained + Provenance hub.

Net file count for the four scenarios: **7 files** (three single-file examples plus
four ex03 legs), versus ~50 had every supporting resource been split out.

## Search parameters

The examples were reviewed against the existing search parameters. Before this work
only four were defined (`identifier`, `status`, `patient`, `subject`): `identifier`
and `status` match every example, but `patient`/`subject` apply only where a
`subject` is present (the ex03 legs), and the transport-defining elements every
example populates — `from`, `to`, `period`, `focus`, `code` (and ex03's
`priorTransport`) — had **no** search coverage at all. Base R6 Transport ships only
`identifier` and `status`, and its location parameters can't be reused because the
redefinition renamed `currentLocation`/`requestedLocation` to `from`/`to`.

`bundle-Transport-search-params.xml` now defines ten search parameters — the two
base parameters plus eight for the redefined R6 elements the examples exercise:

| Code | Type | Expression |
|------|------|------------|
| `identifier` | token | `Transport.identifier` |
| `status` | token | `Transport.status` |
| `code` | token | `Transport.code` |
| `date` | date | `Transport.period` |
| `patient` | reference | `Transport.subject.where(resolve() is Patient)` |
| `subject` | reference | `Transport.subject` |
| `from` | reference → Location | `Transport.from` |
| `to` | reference → Location | `Transport.to` |
| `focus` | reference | `Transport.focus` |
| `prior-transport` | reference → Transport | `Transport.priorTransport` |

The location rename in the redefinition (`currentLocation`/`requestedLocation` →
`from`/`to`) means the base Transport location search parameters do not apply here;
`from`/`to` replace them.

**Disclaimer — contained examples vs. referenceable search.** The search parameters
are defined for the **production model**, where the referenced resources (Patients,
Locations, the transported focus item, prior Transports) are independent,
server-addressable resources (e.g. `Patient/123`, `Location/456`). The examples in
this IG instead **contain** those supporting resources so each example is a single
file, so the reference-based parameters (`patient`, `subject`, `from`, `to`, `focus`,
`prior-transport`) will **not** resolve to searchable targets *within the examples* —
their referents are contained (`#local`) resources with no independent identity. This
is a property of the example packaging only; against production data where those
resources are referenceable, the parameters resolve and search normally. The same
note is embedded as a comment in `bundle-Transport-search-params.xml`.

## Build status

Confirmed on the official **FHIR auto-builder** (`build.fhir.org`, healthy
terminology server): the seven Transport instances validate with **0 errors and
0 warnings** each, and there are **no `dom-3` errors** and **no `resourceDefinition`
errors** anywhere in the IG. The `ip-statements-en` include fix is confirmed — the
IG builds through the Jekyll stage to a full QA report.

Whole-IG CI totals: **37 errors / 129 warnings / 29 broken links** — none from the
Transport examples. The 37 errors are pre-existing issues unrelated to this work —
missing images (`transport-resource-event.png`, `help.png`) and unresolved links
(`workflow-episodeOfCare.html`, SupplyDelivery/SupplyRequest cross-links). Moving to
the self-contained layout (7 files rather than ~50) also reduced whole-IG warnings
from 171 to 129.

> A local `_genonce.sh` run may report far higher numbers (hundreds of errors and
> broken links). That is an artifact of a stale/unreachable `tx.fhir.org`
> terminology-server session — "cache … not known to this server" and
> `validate-code` timeouts multiplied across every resource, plus local anchor
> rendering — and varies run-to-run. Trust the CI QA report, not a local run, for
> the error counts.
