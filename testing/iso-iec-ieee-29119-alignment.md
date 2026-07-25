# ISO/IEC/IEEE 29119 Alignment

**Content type:** Standards guidance and mapping

## Purpose

The ISO/IEC/IEEE 29119 series is WSP's primary software-testing reference. WSP
uses the series to provide consistent vocabulary, processes, documentation, and
test-design techniques while adding concrete automation, CI, traceability, and
release-evidence requirements used by Waughtal projects.

## Referenced Editions

WSP references these published core editions:

| Standard | Subject | WSP use |
| --- | --- | --- |
| ISO/IEC/IEEE 29119-1:2022 | General concepts | Vocabulary and test concepts |
| ISO/IEC/IEEE 29119-2:2021 | Test processes | Planning through completion |
| ISO/IEC/IEEE 29119-3:2021 | Test documentation | Cases, results, and reports |
| ISO/IEC/IEEE 29119-4:2021 | Test techniques | Test design and coverage |

The official ISO catalogue describes Part 1 as the general-concepts foundation,
Part 2 as generic test processes, Part 3 as documentation produced by those
processes, and Part 4 as test-design techniques used within the Part 2 design
and implementation process.

## WSP Mapping

| WSP subject | Primary reference | WSP artifact |
| --- | --- | --- |
| Testing concepts and status | 29119-1 | Test strategy |
| Test planning and control | 29119-2 | Project test strategy |
| Test design and implementation | 29119-2, 29119-4 | Test case |
| Environment and execution | 29119-2 | Runner and execution record |
| Incident handling | 29119-2, 29119-3 | Failure evidence and issue |
| Test-case specification | 29119-3 | LaTeX test-case template |
| Test status and completion | 29119-3 | Generated test report |
| Technique and coverage selection | 29119-4 | Test-technique field |

WSP-TEST-0001 through WSP-TEST-0015 provide the detailed WSP obligations. Each
requirement cites the part of ISO/IEC/IEEE 29119 that most directly informs it.

## WSP Extensions

WSP makes several implementation choices more specific than this high-level
standards mapping:

- stable `REQ-NNNN` and `TC-NNNN` identifiers;
- bidirectional traceability checked in CI;
- structured LaTeX test-case specifications;
- automated test execution whenever feasible;
- generated reports that reuse controlled specifications;
- exact source, toolchain, platform, and configuration metadata;
- preservation of failing results across reruns; and
- release gates across a defined compatibility matrix.

These are WSP requirements. They should not be represented as verbatim
ISO/IEC/IEEE 29119 requirements without a licensed clause-level review.

## Conformity Claims

WSP alignment is not a declaration of conformity. Before claiming that a
project conforms to any part of ISO/IEC/IEEE 29119, the project shall:

1. identify the exact standard edition and applicable clauses;
2. obtain authorized access to the complete standard;
3. create a clause-level conformity or tailoring matrix;
4. resolve gaps between WSP, project practice, and the standard;
5. retain objective evidence for each applicable obligation; and
6. have the claim reviewed and approved under project governance.

## Official References

- [ISO/IEC/IEEE 29119-1:2022 — General concepts][part-1]
- [ISO/IEC/IEEE 29119-2:2021 — Test processes][part-2]
- [ISO/IEC/IEEE 29119-3:2021 — Test documentation][part-3]
- [ISO/IEC/IEEE 29119-4:2021 — Test techniques][part-4]

[part-1]: https://www.iso.org/standard/81291.html
[part-2]: https://www.iso.org/standard/79428.html
[part-3]: https://www.iso.org/standard/79429.html
[part-4]: https://www.iso.org/standard/79430.html
