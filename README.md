# Orders and Observations Incubator IG

## Overview

The Orders & Observations (OO) Incubator Implementation Guide serves as a consolidated workspace for emerging specifications, including FHIR resources, profiles, operations, vocabularies, and artifacts developed by the HL7 Orders & Observations Work Group. It includes resources that are actively evolving and have not yet reached normative status under the FHIR Maturity Model, but may still be suitable for trial use, pilot implementations, and even production deployments where appropriate. These artifacts reflect the current direction of ongoing work but should not be interpreted as stable normative specifications.

This IG defines the scope of exploration for the Orders & Observations Work Group and provides early visibility into emerging content. Implementers are encouraged to assess their risk tolerance, track updates regularly, and participate in the standards development process where possible.

## Building the IG

### Prerequisites
- Node.js and npm installed
- SUSHI (FSH compiler) - install with: `npm install -g fsh-sushi`
- Java runtime environment (for the FHIR IG Publisher)

### Build Instructions

To build the implementation guide, run:

```bash
./_build.sh
```

This will:
1. Install/update dependencies via the FHIR IG Publisher
2. Run SUSHI to compile FSH files into FHIR artifacts
3. Generate the HTML-based implementation guide output

The built output will be available in the `output/` directory.

### Development

- **FSH Resources**: Source files are located in `input/fsh/`
- **XML Resources**: Pre-built resources are in `input/resources/`
- **Configuration**: See `sushi-config.yaml` for IG configuration and `ig.ini` for publisher settings

## Links

- **CI Build**: https://build.fhir.org/ig/HL7/oo-incubator/branches/main/en/
- **FHIR Additional Resources Guidance**: https://build.fhir.org/structuredefinition.html#additional